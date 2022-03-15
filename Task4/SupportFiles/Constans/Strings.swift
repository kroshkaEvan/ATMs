//
//  Strings.swift
//  Task4
//
//  Created by Эван Крошкин on 16.03.22.
//

import Foundation

extension Constants {
    class Strings {
        static let urlString = "https://belarusbank.by/open-banking/v1.0/atms"
        static let availabilityButtonTitle = "Timetable"
        static let map = "Map"
        static let list = "List"
        static let searchBarPlaceholder = "Enter a city"
        static let routeButtonText =  "Build Route"
        static let currentLocation =  "Current location"
        static let cashInYes = "Cash-In: Yes"
        static let cashInNo = "Cash-In: No"
        static let nameDictKey = "Name"
        static let cityDictKey = "City"
        static let internetAlertMessage = "An active internet connection is required for the app to work properly. Please connect to the internet."
        static let internetAlertTitle = "Internet connection unavailable"
        static let internetAlertButtonTitle = "Dismiss"
        static let errorAlertTitle = "Connection error"
        static let errorAlertRepeatButtonTitle = "Retry"
        static let errorAlertCloseButtonTitle = "Close"
    }
    
    enum Days {
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        case sunday
        case weekend

        var shortValue: String {
            switch self {
            case .monday:
                return "Mo"
            case .tuesday:
                return "Tu"
            case .wednesday:
                return "We"
            case .thursday:
                return "Th"
            case .friday:
                return "Fr"
            case .saturday:
                return "Sat"
            case .sunday:
                return "Sun"
            case .weekend:
                return "-"
            }
        }
    }
}
    
    

