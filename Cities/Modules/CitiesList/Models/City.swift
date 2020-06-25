//
//  City.swift
//  Cities
//
//  Created by Mina Mikhael on 25.06.20.
//  Copyright © 2020 Mina Mikhael. All rights reserved.
//

import Foundation

struct City: Codable {
    let id: Int
    let name: String
    let country: String
    let coordinates: MapCoordinates

    enum CodingKeys: String, CodingKey {
        case name, country
        case id = "_id"
        case coordinates = "coord"
    }
}

struct MapCoordinates: Codable {
    let longitude: Double
    let latitude: Double

    enum CodingKeys: String, CodingKey {
         case longitude = "lon"
         case latitude = "lat"
     }
}
