//
//  ForecastTableViewCell.swift
//  Simple & Lightweight Weather
//
//  Created by Roman Radchuk on 31.08.2022.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    struct Constants {
        static let imageBasePath = "https://openweathermap.org/img/wn/%@@2x.png"
    }
    
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var date: UILabel!
    @IBOutlet var weatherDescription: UILabel!
    @IBOutlet var tempRange: UILabel!
    
    lazy var dateFrmatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM - HH:mm"
        return dateFormatter
    }()
    
    func configure(with model: PeriodForecast) {
        self.date.text = dateFrmatter.string(from: model.dt ?? Date())
        let units = UserManager.shared.getSelectedMeasurementUnitsType().temperatureUnitsString()
        self.tempRange.text = "\(model.main.temp_min)\(units) - \(model.main.temp_max)\(units)"
        guard let weather = model.weather.first else { return }
        let imgeUrl = URL(string: String(format: Constants.imageBasePath, weather.icon))
        self.weatherImage.kf.setImage(with: imgeUrl)
        self.weatherDescription.text = weather.description
    }
    
    override func prepareForReuse() {
        self.weatherImage.image = nil
        self.date.text = ""
        self.weatherDescription.text = ""
        self.tempRange.text = ""
    }
}
