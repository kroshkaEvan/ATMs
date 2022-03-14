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
    
    enum Colors {
        static let appMainColor = UIColor(red: 10 / 255,
                                          green: 189 / 255,
                                          blue: 49 / 255,
                                          alpha: 1)
    }
    
    enum Fonts {
        static let defaultFontSize: CGFloat = 14
        static let headerFontSize: CGFloat = 16
        static let cellSubviewsFont = UIFont.systemFont(ofSize: defaultFontSize, weight: .light)
        static let headerFont = UIFont.systemFont(ofSize: headerFontSize, weight: .light)
    }
    
    class Dimensions {
        static let cellsSpacing: CGFloat = 10
        static let defaultPadding: CGFloat = 5
        static let cornerRadius: CGFloat = 7
        static let headerHeight: CGFloat = 30
    }
}
