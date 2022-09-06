//
//  CurrentWeatherModel.swift
//  Simple & Lightweight Weather
//
//  Created by Roman Radchuk on 30.08.2022.
//

import Foundation

struct CurrentWeatherModel: Decodable {
    let id: Int
    let name: String
    let weather: [Weather]
    let coord: Coordinates
    let main: MainWeatherInfo
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Coordinates: Decodable {
    let lon: Double
    let lat: Double
}

struct MainWeatherInfo: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
}
