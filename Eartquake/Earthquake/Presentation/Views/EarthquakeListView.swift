//
//  EarthquakeListView.swift
//  Earthquake
//
//  Created by Lizeth Guadalupe Tafoya Lozano on 10/12/25.
//

import SwiftUI

struct EarthquakeListView: View {
    @StateObject private var viewModel = EarthquakeListViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // Filtro por tipo de sismo
                Picker("Filtrar", selection: $viewModel.filter) {
                    ForEach(EarthquakeListViewModel.Filter.allCases) { option in
                        Text(option.label).tag(option)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                // Selección de fechas
                HStack {
                    DatePicker("Desde", selection: $viewModel.startDate, displayedComponents: .date)
                    DatePicker("Hasta", selection: $viewModel.endDate, in: viewModel.startDate..., displayedComponents: .date)
                }
                .padding(.horizontal)

                // Contenido principal
                Group {
                    if viewModel.isLoading {
                        VStack {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .red))
                                .scaleEffect(1.5)
                                .padding()
                            Text("Analizando actividad sísmica...")
                                .foregroundColor(.secondary)
                        }
                        .transition(.opacity.combined(with: .scale))
                    } else if let error = viewModel.error {
                        VStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.red)
                            Text("Error:")
                                .font(.headline)
                            Text(error.localizedDescription)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Button("Reintentar") {
                                Task { await viewModel.loadEarthquakes() }
                            }
                            .padding(.top)
                        }
                        .padding()
                        .transition(.opacity)
                    } else if viewModel.earthquakes.isEmpty {
                        VStack {
                            Image(systemName: "waveform.path.ecg.rectangle")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                            Text("No se detectaron sismos.")
                                .foregroundColor(.secondary)
                        }
                        .padding(.top)
                        .transition(.opacity)
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 14) {
                                ForEach(viewModel.earthquakes) { quake in
                                    EarthquakeCard(quake: quake)
                                        .transition(.move(edge: .bottom).combined(with: .opacity))
                                }
                            }
                            .padding()
                        }
                    }
                }
                .animation(.easeInOut(duration: 0.3), value: viewModel.earthquakes)
            }
            .navigationTitle("Terremotos")
            .task {
                await viewModel.loadEarthquakes()
            }
            .onChange(of: viewModel.startDate) { _ in reload() }
            .onChange(of: viewModel.endDate) { _ in reload() }
            .onChange(of: viewModel.filter) { _ in reload() }
        }
    }

    private func reload() {
        Task {
            await viewModel.loadEarthquakes()
        }
    }
}
