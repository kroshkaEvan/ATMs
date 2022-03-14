//
//  Map.swift
//  Task4
//
//  Created by Эван Крошкин on 27.03.22.
//

import Foundation

struct Geolocation: Codable {
    let geographicCoordinates: GeographicCoordinates

    enum CodingKeys: String, CodingKey {
        case geographicCoordinates = "GeographicCoordinates"
    }
}

struct GeographicCoordinates: Codable {
    let latitude, longitude: String
}

