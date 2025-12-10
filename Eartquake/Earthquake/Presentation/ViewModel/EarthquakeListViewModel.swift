//
//  EarthquakeListViewModel.swift
//  Earthquake
//
//  Created by Lizeth Guadalupe Tafoya Lozano on 10/12/25.
//



import Foundation
import Combine

@MainActor
class EarthquakeListViewModel: ObservableObject {
    enum Filter: String, CaseIterable, Identifiable {
        case all, strong, weak
        
        var id: String { rawValue }
        var label: String {
            switch self {
            case .all: return "Todos"
            case .strong: return "Fuertes"
            case .weak: return "Leves"
            }
        }
    }

    @Published var earthquakes: [Earthquake] = []
    @Published var isLoading = false
    @Published var error: Error? = nil

    @Published var startDate: Date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
    @Published var endDate: Date = Date()
    @Published var filter: Filter = .all
    
    private let getEarthquakeListUseCase: GetEarthquakeListUseCase
    
    init(getEarthquakeListUseCase: GetEarthquakeListUseCase) {
        self.getEarthquakeListUseCase = getEarthquakeListUseCase
    }

    private let repository = EarthquakeRepositoryImpl(
        remoteDataSource: EarthquakeAPIDataSource()
    )

    func loadEarthquakes() async {
        isLoading = true
        error = nil

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let start = formatter.string(from: startDate)
        let end = formatter.string(from: endDate)

        do {
            let all = try await repository.getEarthquakeList(from: start, to: end)

            switch filter {
            case .all:
                earthquakes = all
            case .strong:
                earthquakes = all.filter { $0.mag >= 5 }
            case .weak:
                earthquakes = all.filter { $0.mag < 5 }
            }
        } catch {
            self.error = error
        }

        isLoading = false
    }
}
