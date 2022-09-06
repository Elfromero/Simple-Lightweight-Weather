//
//  CityModel.swift
//  Simple & Lightweight Weather
//
//  Created by Roman Radchuk on 29.08.2022.
//

import RxDataSources
import RxCoreData
import CoreData

struct CityModel: Codable {
    var id: Int
    var name: String
    var iconID: String
    var weatherDescription: String
    var tempMin: Double?
    var tempMax: Double?
    
    init(_ model: CurrentWeatherModel){
        self.id = model.id
        self.name = model.name
        self.iconID = model.weather.first!.icon
        self.weatherDescription = model.weather.first!.description
        self.tempMin = model.main.temp_min
        self.tempMax = model.main.temp_max
    }
    
    init(with error: Error, for city: CitiesPool){
        self.id = city.id
        self.name = city.rawValue
        self.iconID = ""
        self.weatherDescription = "No data"
        self.tempMax = nil
        self.tempMax = nil
    }
}

func == (lhs: CityModel, rhs: CityModel) -> Bool {
    return lhs.id == rhs.id
}

extension CityModel : Equatable { }

extension CityModel : IdentifiableType {
    public typealias Identity = String

    public var identity: Identity { return "\(id)" }
}

extension CityModel : Persistable {
    
    public typealias T = NSManagedObject
    
    public static var entityName: String {
        return "CityModel"
    }
    
    public static var primaryAttributeName: String {
        return "id"
    }
    
    func predicate() -> NSPredicate {
        return NSPredicate(format: "%K = %d", Self.primaryAttributeName, self.id)
    }
    
    init(entity: T) {
        id = entity.value(forKey: "id") as! Int
        name = entity.value(forKey: "name") as! String
        iconID = entity.value(forKey: "iconID") as! String
        weatherDescription = entity.value(forKey: "weatherDescription") as! String
        tempMin = entity.value(forKey: "tempMin") as? Double
        tempMax = entity.value(forKey: "tempMax") as? Double
    }
    
    public func update(_ entity: NSManagedObject) {
        entity.setValue(id, forKey: "id")
        entity.setValue(name, forKey: "name")
        entity.setValue(iconID, forKey: "iconID")
        entity.setValue(weatherDescription, forKey: "weatherDescription")
        entity.setValue(tempMin, forKey: "tempMin")
        entity.setValue(tempMax, forKey: "tempMax")
    }
}
