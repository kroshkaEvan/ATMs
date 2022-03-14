//
//  Constants.swift
//  Task4
//
//  Created by Эван Крошкин on 14.03.22.
//

import UIKit

class Constants {

    class Strings {
        static let urlString = "https://belarusbank.by/open-banking/v1.0/atms"
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
                return "Пн"
            case .tuesday:
                return "Вт"
            case .wednesday:
                return "Ср"
            case .thursday:
                return "Чт"
            case .friday:
                return "Пт"
            case .saturday:
                return "Сб"
            case .sunday:
                return "Вс"
            case .weekend:
                return "-"
            }
        }
    }

    class Location {
        static let distanceSpan: Double = 500
    }
}
