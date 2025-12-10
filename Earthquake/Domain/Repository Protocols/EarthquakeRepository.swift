//
//  EarthquakeRepository.swift
//  Earthquake
//
//  Created by Lizeth Guadalupe Tafoya Lozano on 10/12/25.
//

protocol EarthquakeRepository {
    func getEarthquakeList(from startDate: String, to endDate: String) async throws -> [Earthquake]
}
