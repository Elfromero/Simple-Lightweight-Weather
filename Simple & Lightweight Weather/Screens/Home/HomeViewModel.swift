//
//  HomeViewModel.swift
//  Simple & Lightweight Weather
//
//  Created by Roman Radchuk on 29.08.2022.
//

import Foundation
import RxSwift

protocol HomeViewModel {
    var cities: Observable<[CityModel]> { get }
    var searchingText: PublishSubject<String?> { get }
    func refreshData()
}

class DefaultHomeViewModel: HomeViewModel {
    
    private let provider: HomeDataProvider
    
    var cities: Observable<[CityModel]>
    var searchingText: PublishSubject<String?> = PublishSubject()
    
    init(provider: HomeDataProvider) {
        
        self.provider = provider
        self.cities = Observable.combineLatest(provider.cities, searchingText.startWith(""))
            .map({ (models, searchText) in
                return models.filter(){
                    guard let searchText = searchText, searchText != "" else { return true }
                    return $0.name.contains(searchText)
                }
            })
    }
    
    func refreshData() {
        provider.refreshCitiesCurrentWeather()
    }
}
