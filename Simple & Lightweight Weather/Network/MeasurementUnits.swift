//
//  MeasurementUnits.swift
//  Simple & Lightweight Weather
//
//  Created by Roman Radchuk on 31.08.2022.
//

import Foundation

enum MeasurementUnits: String {
    case metric
    case imperial
    
    func switchUnits() -> MeasurementUnits {
        switch self {
        case .metric: return .imperial
        case .imperial: return .metric
        }
    }
    
    func temperatureUnitsString() -> String {
        switch self {
        case .metric: return "℃"
        case .imperial: return "℉"
        }
    }
}
