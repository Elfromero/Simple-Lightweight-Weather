//
//  CityDetailsDataProvider.swift
//  Simple & Lightweight Weather
//
//  Created by Roman Radchuk on 31.08.2022.
//

import RxSwift
import RxRelay

protocol CityDetailsDataProvider {
    var forecast: Observable<[PeriodForecast]?> { get }
    
    func refreshForecast()
}

class DefaultCityDetailsDataProvider: CityDetailsDataProvider {

    var forecast: Observable<[PeriodForecast]?>
    var cityModel: CityModel
    
    private let apiClient: APINetworkClient
    private let forecastRelay: BehaviorRelay<[PeriodForecast]?> = BehaviorRelay(value: [])
    private let disposedBag = DisposeBag()

    init(apiClient: APINetworkClient, cityModel: CityModel) {
        self.apiClient = apiClient
        self.cityModel = cityModel
        forecast = forecastRelay.asObservable()
    }
    
    func refreshForecast() {
        fetchData()
    }
    
    private func fetchData() {
        apiClient.getForecast(for: cityModel.id)
            .map(){$0.list}
            .subscribe { [weak self] forecastList in
                self?.forecastRelay.accept(forecastList)
            } onError: { [weak self] error in
                self?.forecastRelay.accept(nil)
            }.disposed(by: disposedBag)
    }
}
