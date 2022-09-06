//
//  CityDetailsViewModel.swift
//  Simple & Lightweight Weather
//
//  Created by Roman Radchuk on 31.08.2022.
//

import RxSwift

protocol CityDetailsViewModel {
    var forecast: Observable<[PeriodForecast]?> { get }
    
    func refreshForecast()
}

class DefaultCityDetailsViewModel: CityDetailsViewModel {
    
    var forecast: Observable<[PeriodForecast]?>
    
    private let provider: CityDetailsDataProvider
    
    init(provider: CityDetailsDataProvider) {
        
        self.provider = provider
        self.forecast = provider.forecast
    }
    
    func refreshForecast() {
        self.provider.refreshForecast()
    }
}
