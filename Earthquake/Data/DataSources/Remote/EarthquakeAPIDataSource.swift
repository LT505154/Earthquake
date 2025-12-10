//
//  EarthquakeAPIDataSource.swift
//  Earthquake
//
//  Created by Lizeth Guadalupe Tafoya Lozano on 09/12/25.
//

//Aquí se consume la API y se define el protocolo

import Foundation

protocol EarthquakeRemoteDataSource {
    func fetchEarthquake(from startDate: String, to endDate: String) async throws -> [EarthquakeFeatureDTO]
}

class EarthquakeAPIDataSource:EarthquakeRemoteDataSource{
    func fetchEarthquake(from startDate: String, to endDate: String) async throws -> [EarthquakeFeatureDTO]{

        var components = URLComponents(string: "https://earthquake.usgs.gov/fdsnws/event/1/query")!
        components.queryItems = [
            URLQueryItem(name: "format", value: "geojson"),
            URLQueryItem(name: "starttime", value: startDate),
            URLQueryItem(name: "endtime", value: endDate)
        ]
        
        guard let url = components.url else {
            fatalError("URL inválida")
        }
        
        let (data,_) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(EarthquakeResponseDTO.self, from: data)
        return response.features
        
    }
}
