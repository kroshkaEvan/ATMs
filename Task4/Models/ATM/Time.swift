//
//  Time.swift
//  Task4
//
//  Created by Эван Крошкин on 27.03.22.
//

import Foundation

struct Availability: Codable {
    let access24Hours, isRestricted, sameAsOrganization: Bool
    let standardAvailability: StandardAvailability

    enum CodingKeys: String, CodingKey {
        case access24Hours, isRestricted, sameAsOrganization
        case standardAvailability = "StandardAvailability"
    }
}

struct StandardAvailability: Codable {
    let day: [Day]

    enum CodingKeys: String, CodingKey {
        case day = "Day"
    }
}

struct Day: Codable {
    let dayCode: String
    let openingTime: OpeningTime
    let closingTime: ClosingTime
    let dayBreak: Break

    enum CodingKeys: String, CodingKey {
        case dayCode, openingTime, closingTime
        case dayBreak = "Break"
    }
}

enum ClosingTime: String, Codable {
    case the1300 = "13:00"
    case the1500 = "15:00"
    case the1545 = "15:45"
    case the1600 = "16:00"
    case the1615 = "16:15"
    case the1700 = "17:00"
    case the1730 = "17:30"
    case the1800 = "18:00"
    case the1900 = "19:00"
    case the2000 = "20:00"
    case the2100 = "21:00"
    case the2200 = "22:00"
    case the2300 = "23:00"
    case the2359 = "23:59"
    case the2400 = "24:00"
}

struct Break: Codable {
    let breakFromTime: BreakFromTime
    let breakToTime: BreakToTime
}

enum BreakFromTime: String, Codable {
    case the0000 = "00:00"
    case the0200 = "02:00"
    case the0400 = "04:00"
    case the1100 = "11:00"
    case the1230 = "12:30"
    case the1345 = "13:45"
    case the1400 = "14:00"
    case the1500 = "15:00"
}

enum BreakToTime: String, Codable {
    case the0000 = "00:00"
    case the0700 = "07:00"
    case the0830 = "08:30"
    case the0900 = "09:00"
    case the1200 = "12:00"
    case the1315 = "13:15"
    case the1500 = "15:00"
    case the1700 = "17:00"
}

enum OpeningTime: String, Codable {
    case the0000 = "00:00"
    case the0430 = "04:30"
    case the0500 = "05:00"
    case the0600 = "06:00"
    case the0630 = "06:30"
    case the0700 = "07:00"
    case the0800 = "08:00"
    case the0830 = "08:30"
    case the0900 = "09:00"
    case the1000 = "10:00"
}
