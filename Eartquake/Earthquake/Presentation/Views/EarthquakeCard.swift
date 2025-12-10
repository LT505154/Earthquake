//
//  EarthquakeCard.swift
//  Earthquake
//
//  Created by Lizeth Guadalupe Tafoya Lozano on 10/12/25.
//

import SwiftUI

struct EarthquakeCard: View {
    let quake: Earthquake

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "waveform.path.ecg")
                    .foregroundColor(colorForMagnitude)
                Text(quake.place)
                    .font(.headline)
                Spacer()
                Text("M \(quake.mag, specifier: "%.1f")")
                    .font(.title3.bold())
                    .foregroundColor(colorForMagnitude)
            }

            Text(
                Date(timeIntervalSince1970: TimeInterval(quake.time) / 1000)
                    .formatted(.dateTime.day().month().year().hour().minute())
            )
            .font(.caption)
            .foregroundColor(.secondary)



            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .frame(height: 8)
                        .foregroundColor(.gray.opacity(0.2))
                    Capsule()
                        .frame(width: CGFloat(min(quake.mag / 10, 1.0)) * geo.size.width, height: 8)
                        .foregroundColor(colorForMagnitude)
                        .animation(.easeInOut(duration: 0.4), value: quake.mag)
                }
            }
            .frame(height: 8)
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: colorForMagnitude.opacity(0.3), radius: 6, x: 0, y: 2)
    }

    private var colorForMagnitude: Color {
        switch quake.mag {
        case 0..<3: return .green
        case 3..<5: return .orange
        default: return .red
        }
    }
}
