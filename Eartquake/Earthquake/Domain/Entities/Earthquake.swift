//
//  Earthquake.swift
//  Earthquake
//
//  Created by Lizeth Guadalupe Tafoya Lozano on 10/12/25.
//

import Foundation

struct Earthquake: Identifiable, Equatable {
    let id: String
    let mag: Double
    let place: String
    let time: Int
    let coordinates: [Double]
}
