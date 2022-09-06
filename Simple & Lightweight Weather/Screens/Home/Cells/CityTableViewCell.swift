//
//  CityTableViewCell.swift
//  Simple & Lightweight Weather
//
//  Created by Roman Radchuk on 29.08.2022.
//

import UIKit
import Kingfisher

class CityTableViewCell: UITableViewCell {
    
    struct Constants {
        static let imageBasePath = "https://openweathermap.org/img/wn/%@@2x.png"
    }
    
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var cityName: UILabel!
    @IBOutlet var weatherDescription: UILabel!
    @IBOutlet var tempRange: UILabel!
    
    func configure(with model: CityModel) {
        let imgeUrl = URL(string: String(format: Constants.imageBasePath, model.iconID))
        self.weatherImage.kf.setImage(with: imgeUrl)
        self.cityName.text = model.name
        self.weatherDescription.text = model.weatherDescription
        guard let tempMin = model.tempMin, let tempMax = model.tempMax else { return }
        let units = UserManager.shared.getSelectedMeasurementUnitsType().temperatureUnitsString()
        self.tempRange.text = "\(tempMin)\(units) - \(tempMax)\(units)"
    }
    
    override func prepareForReuse() {
        self.weatherImage.image = nil
        self.cityName.text = ""
        self.weatherDescription.text = ""
        self.tempRange.text = ""
    }
}
