//
//  DIContainer.swift
//  Earthquake
//
//  Created by Lizeth Guadalupe Tafoya Lozano on 09/12/25.
//

@MainActor
class DIContainer {
    static let shared = DIContainer()
    private init() {}
    
    private lazy var remoteDataSource: EarthquakeRemoteDataSource = {
        EarthquakeAPIDataSource()
    }()
    
    private lazy var earthquakeRepository: EarthquakeRepository = {
        EarthquakeRepositoryImpl(remoteDataSource: remoteDataSource)
    }()
    
    func makeGetEarthquakeListUseCase() -> GetEarthquakeListUseCase {
        GetEarthquakeListUseCaseImpl(repository: earthquakeRepository)
    }
    
    func makeEarthquakeListViewModel() -> EarthquakeListViewModel {
        EarthquakeListViewModel(getEarthquakeListUseCase: makeGetEarthquakeListUseCase())
    }
}
