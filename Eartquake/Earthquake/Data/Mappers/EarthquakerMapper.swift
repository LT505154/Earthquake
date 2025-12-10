//
//  EarthquakerMapper.swift
//  Earthquake
//
//  Created by Lizeth Guadalupe Tafoya Lozano on 09/12/25.
//

import Foundation

class EarthquakeMapper {
    static func toDomain(dto: EarthquakeFeatureDTO) -> Earthquake {
        let coords = dto.geometry.coordinates
        
        return Earthquake(
            id: dto.id,
            mag: dto.properties.mag,
            place: dto.properties.place,
            time: dto.properties.time,
            coordinates: dto.geometry.coordinates
        )
    }
}
