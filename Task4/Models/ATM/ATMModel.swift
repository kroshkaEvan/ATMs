//
//  ATMModel.swift
//  Task4
//
//  Created by Эван Крошкин on 27.03.22.
//

import Foundation
import MapKit

struct ATMModel: Codable {
    let data: DataClass

    enum CodingKeys: String, CodingKey {
        case data = "Data"
    }
}

struct DataClass: Codable {
    let atm: [ATM]

    enum CodingKeys: String, CodingKey {
        case atm = "ATM"
    }
}

enum Currency: String, Codable {
    case byn = "BYN"
    case bynUsd = "BYN/USD"
}

enum Card: String, Codable {
    case belkart = "BELKART"
    case mir = "MIR"
    case unionPay = "UnionPay"
    case visa = "VISA"
}

struct ContactDetails: Codable {
    let phoneNumber: String
}

enum CurrentStatus: String, Codable {
    case off = "Off"
    case on = "On"
}

enum TypeEnum: String, Codable {
    case atm = "ATM"
}

struct ATM: Codable {
    let atmID: String
    let type: TypeEnum
    let baseCurrency, currency: Currency
    let cards: [Card]
    let currentStatus: CurrentStatus
    let address: Address
    let services: [Service]
    let availability: Availability
    let contactDetails: ContactDetails
    let accessibilities: Accessibilities?

    enum CodingKeys: String, CodingKey {
        case atmID = "atmId"
        case type, baseCurrency, currency, cards, currentStatus
        case address = "Address"
        case services = "Services"
        case availability = "Availability"
        case contactDetails = "ContactDetails"
        case accessibilities = "Accessibilities"
    }
}
