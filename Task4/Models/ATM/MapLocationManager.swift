//
//  Map.swift
//  Task4
//
//  Created by Эван Крошкин on 27.03.22.
//

import Foundation
import CoreLocation
import UIKit

struct Geolocation: Codable {
    let geographicCoordinates: GeographicCoordinates

    enum CodingKeys: String, CodingKey {
        case geographicCoordinates = "GeographicCoordinates"
    }
}

struct GeographicCoordinates: Codable {
    let latitude, longitude: String
}

class LocationManager {
    static let shared = LocationManager()
    private let manager: CLLocationManager
    
    private init() {
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.activityType = .automotiveNavigation
        manager.requestAlwaysAuthorization()
    }

    func setDelegate(_ delegate: CLLocationManagerDelegate) {
        manager.delegate = delegate
    }

    func startUpdatingLocation() {
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
        }
    }

    func stopUpdatingLocation() {
        manager.stopUpdatingLocation()
    }
}


