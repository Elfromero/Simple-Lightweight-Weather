//
//  ForecastWeatherModel.swift
//  Simple & Lightweight Weather
//
//  Created by Roman Radchuk on 31.08.2022.
//

import Foundation

struct ForecastWeatherModel: Decodable {
    let list: [PeriodForecast]
}

struct PeriodForecast: Decodable {
    let dt: Date
    let weather: [Weather]
    let main: MainWeatherInfo
}
