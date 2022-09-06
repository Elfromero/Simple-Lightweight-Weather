//
//  HomeDataProvider.swift
//  Simple & Lightweight Weather
//
//  Created by Roman Radchuk on 29.08.2022.
//

import RxSwift
import RxCoreData
import CoreData

protocol HomeDataProvider {
    var cities: Observable<[CityModel]> { get }
    func refreshCitiesCurrentWeather()
}

class DefaultHomeDataProvider: HomeDataProvider {
    
    private let apiClient: APINetworkClient
    private let managedObjectContext: NSManagedObjectContext
    private let disposedBag = DisposeBag()
    
    var cities: Observable<[CityModel]>    
    
    init(context: NSManagedObjectContext, apiClient: APINetworkClient) {
        self.managedObjectContext = context
        self.apiClient = apiClient
        cities = managedObjectContext.rx.entities(CityModel.self, sortDescriptors: [NSSortDescriptor(key: "name", ascending: false)])
    }
    
    func refreshCitiesCurrentWeather() {
        fetchCitiesData()
    }
    
    private func fetchCitiesData() {
        CitiesPool.allCases.forEach(){ city in
            apiClient.getCurrentWether(for: city.id).subscribe { [unowned self] currentWeatherModel in
                self.save(CityModel(currentWeatherModel))
            } onError: { [unowned self] error in
                self.save(CityModel(with: error, for: city ))
            }.disposed(by: disposedBag)

        }
    }
    
    private func save<T:Persistable>(_ model: T) {
        DispatchQueue.main.async { [weak self] in
            try? self?.managedObjectContext.rx.update(model)
        }
    }
    
}
