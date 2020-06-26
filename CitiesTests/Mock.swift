//
//  Mock.swift
//  CitiesTests
//
//  Created by Mina Mikhael on 26.06.20.
//  Copyright © 2020 Mina Mikhael. All rights reserved.
//

import Foundation
@testable import Cities

internal extension City {
    static func getMockCity() -> City {
        return City(id: 1, name: "Amsterdam", country: "NL", coordinates: MapCoordinates(longitude: 4.88969, latitude: 52.374031))
    }
    static func getMockFetchCitiesResponse () -> [City] {
        return [City.getMockCity()]
    }
}

internal extension CityViewModel {
    static func getMockCityViewModel() -> CityViewModel {
        return CityViewModel(city: City.getMockCity())
    }
}
