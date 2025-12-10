//
//  EarthquakeApp.swift
//  Earthquake
//
//  Created by Lizeth Guadalupe Tafoya Lozano on 09/12/25.
//

import SwiftUI

@main
struct EarthquakeApp: App {
    let container = DIContainer.shared

    var body: some Scene {
        WindowGroup {
            EarthquakeListView(viewModel: container.makeEarthquakeListViewModel())
        }
    }
}
