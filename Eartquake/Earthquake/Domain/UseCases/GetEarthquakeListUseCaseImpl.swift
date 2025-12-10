//
//  GetEarthquakeListUseCaseImpl.swift
//  Earthquake
//
//  Created by Lizeth Guadalupe Tafoya Lozano on 10/12/25.
//

protocol GetEarthquakeDetailUseCase {
    func execute(from startDate: String, to endDate: String) async throws -> [Earthquake]
}

class GetEarthquakeDetailUseCaseImpl: GetEarthquakeListUseCase {
    private let repository: EarthquakeRepository
    
    init(repository: EarthquakeRepository){
        self.repository = repository
    }
    
    func execute(from startDate: String, to endDate: String) async throws -> [Earthquake]{
        return try await repository.getEarthquakeList(from: startDate,to: endDate)
    }
}
