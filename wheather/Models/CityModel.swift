//
//  CityModel.swift
//  wheather
//
//  Created by Atirek Pothiwala on 05/02/25.
//

import Foundation
import MapKit

struct CityModel: Identifiable, Codable {
    let id = UUID()
    let name: String
    let location: Location
}

struct Location: Codable {
    let latitude: Double
    let longitude: Double
}

extension Location {
    func toRegion() -> MKCoordinateRegion {
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.75, longitudeDelta: 0.75)
        )
    }
}
