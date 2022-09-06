//
//  APINetworkClient.swift
//  Simple & Lightweight Weather
//
//  Created by Roman Radchuk on 30.08.2022.
//

import RxSwift
import Alamofire

protocol APINetworkClient {
    func getCurrentWether(for city: String) -> Observable<CurrentWeatherModel>
    func getCurrentWether(for cityID: Int) -> Observable<CurrentWeatherModel>
    func getForecast(for city: String) -> Observable<ForecastWeatherModel>
    func getForecast(for cityID: Int) -> Observable<ForecastWeatherModel>
}

class OpenWeatherAPINetworkClient: APINetworkClient {
    struct Constants {
        static let baseURL = "https://api.openweathermap.org"
        static let getWeather = "/data/2.5/weather"
        static let getForecast = "/data/2.5/forecast"
        static let apiToken = "0cd74bf29e43ef1ad6afd6861cc99eb2"
        struct queryKey {
            static let appID = "appid"
            static let locationName = "q"
            static let citiID = "id"
            static let units = "units"
        }
        struct Units {
            static let metric = "metric"
            static let imperial = "imperial"
        }
    }
    
    func getCurrentWether(for cityID: Int) -> Observable<CurrentWeatherModel> {
        let urlString = Constants.baseURL + Constants.getWeather
        let params: Parameters = [Constants.queryKey.appID: Constants.apiToken,
                                  Constants.queryKey.citiID: cityID,
                                  Constants.queryKey.units: UserManager.shared.getSelectedMeasurementUnitsType()
        ]
        return perform(with: AF.request(urlString,
                                     method: .get,
                                     parameters: params), modelType: CurrentWeatherModel.self)
    }
    
    func getCurrentWether(for city: String) -> Observable<CurrentWeatherModel> {
        let urlString = Constants.baseURL + Constants.getWeather
        let params: Parameters = [Constants.queryKey.appID: Constants.apiToken,
                                  Constants.queryKey.locationName: city,
                                  Constants.queryKey.units: UserManager.shared.getSelectedMeasurementUnitsType()
        ]
        return perform(with: AF.request(urlString,
                                     method: .get,
                                     parameters: params), modelType: CurrentWeatherModel.self)
    }
    
    func getForecast(for cityID: Int) -> Observable<ForecastWeatherModel> {
        let urlString = Constants.baseURL + Constants.getForecast
        let params: Parameters = [Constants.queryKey.appID: Constants.apiToken,
                                  Constants.queryKey.citiID: cityID,
                                  Constants.queryKey.units: UserManager.shared.getSelectedMeasurementUnitsType()
        ]
        return perform(with: AF.request(urlString,
                                     method: .get,
                                     parameters: params), modelType: ForecastWeatherModel.self)
    }
    
    func getForecast(for city: String) -> Observable<ForecastWeatherModel> {
        let urlString = Constants.baseURL + Constants.getForecast
        let params: Parameters = [Constants.queryKey.appID: Constants.apiToken,
                                  Constants.queryKey.locationName: city,
                                  Constants.queryKey.units: UserManager.shared.getSelectedMeasurementUnitsType()
        ]
        return perform(with: AF.request(urlString,
                                     method: .get,
                                     parameters: params), modelType: ForecastWeatherModel.self)
    }
    
    
    private func perform<T:Decodable>(with request: DataRequest, modelType: T.Type) -> Observable<T> {
        return Observable<T>.create { observer -> Disposable in
            request.responseDecodable(of: modelType) { response in
                switch response.result {
                case .success(let model):
                    observer.onNext(model)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
