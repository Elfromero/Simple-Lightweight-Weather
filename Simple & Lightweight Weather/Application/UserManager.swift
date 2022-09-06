//
//  UserManager.swift
//  Simple & Lightweight Weather
//
//  Created by Roman Radchuk on 31.08.2022.
//

import Foundation

class UserManager: NSObject {
    
    static let shared: UserManager = {
      let instance = UserManager()
      return instance
    }()
    
    func setSelectedMeasurementUnitsType(_ type: MeasurementUnits) {
        UserDefaults.standard.set(type.rawValue, forKey: UDKeys.measurementUnits)
    }
    
    func getSelectedMeasurementUnitsType() -> MeasurementUnits {
        guard let value = UserDefaults.standard.string(forKey: UDKeys.measurementUnits) else {
            return .metric
        }
        return MeasurementUnits(rawValue: value) ?? .metric
    }
    
    struct UDKeys {
        static let measurementUnits = "SelectedMeasurementUnits"
    }
}

