//
//  WeatherService.swift
//  wheather
//
//  Created by Atirek Pothiwala on 05/02/25.
//

import Foundation

class WeatherService {
    
    func fetchData(_ location: Location, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        guard var url = URL(string: "https://api.open-meteo.com/v1/forecast") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 404, userInfo: nil)))
            return
        }
        url = url.appending(queryItems: [
            URLQueryItem(name: "latitude", value: "\(location.latitude)"),
            URLQueryItem(name: "longitude", value: "\(location.longitude)"),
            URLQueryItem(name: "current", value: [
                "temperature_2m",
                "relative_humidity_2m",
                "rain",
                "snowfall",
                "wind_speed_10m",
                "wind_direction_10m"
            ].joined(separator: ",")),
            URLQueryItem(name: "timeformat", value: "unixtime"),
            URLQueryItem(name: "timezone", value: "Asia/Kolkata"),
            URLQueryItem(name: "forecast_days", value: "1"),
        ])
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        debugPrint("Request: \(request.url!.absoluteString)")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Data Not Found", code: 404, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                if let json = String(data: data, encoding: .utf8) {
                    debugPrint("Response: \(json)")
                }
                let weatherData = try decoder.decode(WeatherModel.self, from: data)
                completion(.success(weatherData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
