//
//  CityViewModel.swift
//  Cities
//
//  Created by Mina Mikhael on 25.06.20.
//  Copyright © 2020 Mina Mikhael. All rights reserved.
//

import Foundation
import MapKit

class CityViewModel {

    private var city: City

    init(city: City) {
        self.city = city
    }

    func cityName() -> String {
        return "\(city.name), \(city.country)"
    }

    func cityCoordsDescription() -> String {
        return "\(city.coordinates.latitude), \(city.coordinates.longitude)"
    }

    func cityCoords() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: city.coordinates.latitude, longitude: city.coordinates.longitude)
    }

    func location() -> CLLocation {
        return CLLocation(latitude: city.coordinates.latitude, longitude: city.coordinates.longitude)
    }
}
