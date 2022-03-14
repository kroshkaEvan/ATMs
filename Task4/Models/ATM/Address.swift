//
//  Address.swift
//  Task4
//
//  Created by Эван Крошкин on 27.03.22.
//

import Foundation

enum Country: String, Codable {
    case by = "BY"
}

enum CountrySubDivision: String, Codable {
    case минск = "Минск"
    case минская = "Минская"
    case брестская = "Брестская"
    case витебская = "Витебская"
    case гомельская = "Гомельская"
    case гродненская = "Гродненская"
    case могилевская = "Могилевская"
}

struct Address: Codable {
    let streetName, buildingNumber, townName: String
    let countrySubDivision: CountrySubDivision
    let country: Country
    let addressLine: String
    let addressDescription: AddressDescription
    let geolocation: Geolocation

    enum CodingKeys: String, CodingKey {
        case streetName, buildingNumber, townName, countrySubDivision, country, addressLine
        case addressDescription = "description"
        case geolocation = "Geolocation"
    }
}

enum AddressDescription: String, Codable {
    case внешний = "Внешний"
    case внутренний = "Внутренний"
    case уличный = "Уличный"
}
