//
//  EarthquakeDTO.swift
//  Earthquake
//
//  Created by Lizeth Guadalupe Tafoya Lozano on 10/12/25.
//

struct EarthquakeDTO: Codable {
    let id: String
    let mag: Double
    let place: String
    let time: Int
    let coordinates: [Double]
}
