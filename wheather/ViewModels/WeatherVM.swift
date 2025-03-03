//
//  DetailPageVM.swift
//  wheather
//
//  Created by Atirek Pothiwala on 05/02/25.
//

import Foundation
import CoreLocation

class WeatherVM: ObservableObject {
    private let service = WeatherService()
    
    @Published var weatherData: WeatherModel?
    @Published var errorMessage: String?
    
    @Published var weatherTitle: String?
    @Published var weatherImage: String?
    
    @Published var windDirection: String?
    @Published var windSpeed: String?
    @Published var temperature: String?
    
    func fetchWeather(_ location: Location) {
        service.fetchData(location) {
            [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.checkWeather(data)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    private func checkWeather(_ data: WeatherModel){
        self.weatherData = data
        
        let temperature = data.current?.temperature_2m ?? 0
        let temperatureUnit = data.current_units?.temperature_2m ?? ""
        self.temperature = String(format: "%.1f\n%@", temperature, temperatureUnit)
        
        let windSpeed = data.current?.wind_speed_10m ?? 0
        let windSpeedUnit = data.current_units?.wind_speed_10m ?? ""
        self.windSpeed = String(format: "%.1f\n%@", windSpeed, windSpeedUnit)
        
        let windDirection = data.current?.wind_direction_10m ?? 0
        let windDirectionUnit = data.current_units?.wind_direction_10m ?? ""
        self.windDirection = String(format: "%.1f%@", windDirection, windDirectionUnit)
        
        self.weatherTitle = data.weatherDay.name
        
        let isRainy: Bool = (data.current?.rain ?? 0) > 0
        let isSnowy: Bool = (data.current?.snowfall ?? 0) > 0
        
        if isRainy {
            switch data.weatherDay {
            case .morning, .afternoon:
                weatherImage = "cloud.sun.rain.fill"
                break
            case .evening, .night:
                weatherImage = "cloud.moon.rain.fill"
                break
            default:
                break
            }
        } else if isSnowy {
            weatherImage = "snow"
        } else {
            switch data.weatherDay {
            case .morning, .afternoon:
                weatherImage = "sun.max.fill"
                break
            case .evening, .night:
                weatherImage = "moon.stars.fill"
                break
            default:
                break
            }
        }
    }
}
