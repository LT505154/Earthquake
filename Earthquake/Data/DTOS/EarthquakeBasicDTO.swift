//
//  EarthquakeDTO.swift
//  Earthquake
//
//  Created by Lizeth Guadalupe Tafoya Lozano on 09/12/25.
//

/*Se crean las estructuras como viene en el JSON
/features
    properties
    geometry
*/

struct EarthquakeResponseDTO: Codable {
    let features: [EarthquakeFeatureDTO]
}

struct EarthquakeFeatureDTO: Codable {
    let properties: EarthquakePropertiesDTO
    let geometry: EarthquakeGeometryDTO
    let id: String
}

struct EarthquakePropertiesDTO: Codable {
    let mag: Double
    let place: String
    let time: Int
}

struct EarthquakeGeometryDTO: Codable {
    let coordinates: [Double]
}

