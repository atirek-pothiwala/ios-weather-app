//
//  CityService.swift
//  wheather
//
//  Created by Atirek Pothiwala on 06/02/25.
//

import Foundation

class CityService {
    func fetchCities() -> [CityModel] {        
        do {
            if let url = Bundle.main.url(forResource: "cities", withExtension: "json") {
                let data = try Data(contentsOf: url)
                if let json = String(data: data, encoding: .utf8) {
                    debugPrint("JSON: \(json)")
                }
                return try JSONDecoder().decode([CityModel].self, from: data)
            }
        } catch {
            debugPrint("Error: \(error.localizedDescription)")
        }
        return []
    }
}
