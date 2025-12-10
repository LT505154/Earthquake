//
//  EarthquakeRepositoryImpl.swift
//  Earthquake
//
//  Created by Lizeth Guadalupe Tafoya Lozano on 09/12/25.
//

class EarthquakeRepositoryImpl: EarthquakeRepository {
    private let remoteDataSource: EarthquakeRemoteDataSource
    
    init(remoteDataSource: EarthquakeRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getEarthquakeList(from startDate: String, to endDate: String) async throws -> [Earthquake]{
        let dto = try await remoteDataSource.fetchEarthquake(from: startDate, to: endDate)
        return dto.map {EarthquakeMapper.toDomain(dto: $0)}
    }
}
