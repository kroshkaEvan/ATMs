//
//  Strings.swift
//  Task4
//
//  Created by Эван Крошкин on 16.03.22.
//

import Foundation

extension Constants {
    class Strings {
        static let urlATMs = "https://belarusbank.by/open-banking/v1.0/atms"
        static let urlCurrency = "https://belarusbank.by/api/kursExchange"
        static let availabilityButtonTitle = "Timetable".localizated()
        static let map = "Map".localizated()
        static let list = "List".localizated()
        static let section = "Section"
        static let currency = "Currency:".localizated()
        static let searchBarPlaceholder = "Enter a city".localizated()
        static let routeButtonText =  "Build Route".localizated()
        static var currentLocation =  "Current location".localizated()
        static let cashInYes = "Cash-In: Yes".localizated()
        static let cashInNo = "Cash-In: No".localizated()
        static let unionPayYes = "Card service UnionPay: Yes".localizated()
        static let unionPayNo = "Card service UnionPay: No".localizated()
        static let nameDictKey = "Name"
        static let cityDictKey = "City"
        static let service = "Service centers".localizated()
        static let internetAlertMessage = "An active internet connection is required for the app to work properly. Please connect to the internet.".localizated()
        static let internetAlertTitle = "Internet connection unavailable".localizated()
        static let internetAlertButtonTitle = "Cancel".localizated()
        static let errorAlertTitle = "Connection error".localizated()
        static let errorAlertRepeatButtonTitle = "Retry".localizated()
        static let errorAlertCloseButtonTitle = "Close".localizated()
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

        var shortName: String {
            switch self {
            case .monday:
                return "Monday".localizated()
            case .tuesday:
                return "Tuesday".localizated()
            case .wednesday:
                return "Wednesday".localizated()
            case .thursday:
                return "Thursday".localizated()
            case .friday:
                return "Friday".localizated()
            case .saturday:
                return "Saturday".localizated()
            case .sunday:
                return "Sunday".localizated()
            case .weekend:
                return "-"
            }
        }
    }
}

extension String {
    func localizated() -> String {
        return NSLocalizedString(self,
                                 tableName: "Localization",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}
    
    

