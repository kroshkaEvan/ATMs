//
//  Currency.swift
//  Task4
//
//  Created by Эван Крошкин on 2.04.22.
//

import Foundation

struct CurrencyModel: Codable {
    let usdIn, usdOut, eurIn, eurOut: String
    let rubIn, rubOut, gbpIn, gbpOut: String
    let cadIn, cadOut, plnIn, plnOut: String
    let uahIn, uahOut, sekIn, sekOut: String
    let chfIn, chfOut, usdEURIn, usdEUROut: String
    let usdRUBIn, usdRUBOut, rubEURIn, rubEUROut: String
    let jpyIn, jpyOut, cnyIn, cnyOut: String
    let czkIn, czkOut, nokIn, nokOut: String
    let filialID, sapID, infoWorktime: String
    let streetType: StreetType
    var street, filialsText, homeNumber, name: String
    let nameType: NameType

    enum CodingKeys: String, CodingKey {
        case usdIn = "USD_in"
        case usdOut = "USD_out"
        case eurIn = "EUR_in"
        case eurOut = "EUR_out"
        case rubIn = "RUB_in"
        case rubOut = "RUB_out"
        case gbpIn = "GBP_in"
        case gbpOut = "GBP_out"
        case cadIn = "CAD_in"
        case cadOut = "CAD_out"
        case plnIn = "PLN_in"
        case plnOut = "PLN_out"
        case uahIn = "UAH_in"
        case uahOut = "UAH_out"
        case sekIn = "SEK_in"
        case sekOut = "SEK_out"
        case chfIn = "CHF_in"
        case chfOut = "CHF_out"
        case usdEURIn = "USD_EUR_in"
        case usdEUROut = "USD_EUR_out"
        case usdRUBIn = "USD_RUB_in"
        case usdRUBOut = "USD_RUB_out"
        case rubEURIn = "RUB_EUR_in"
        case rubEUROut = "RUB_EUR_out"
        case jpyIn = "JPY_in"
        case jpyOut = "JPY_out"
        case cnyIn = "CNY_in"
        case cnyOut = "CNY_out"
        case czkIn = "CZK_in"
        case czkOut = "CZK_out"
        case nokIn = "NOK_in"
        case nokOut = "NOK_out"
        case filialID = "filial_id"
        case sapID = "sap_id"
        case infoWorktime = "info_worktime"
        case street ,streetType = "street_type"
        case filialsText = "filials_text"
        case homeNumber = "home_number"
        case name, nameType = "name_type"
    }
}

enum NameType: String, Codable {
    case empty = ""
    case агрогородок = "агрогородок"
    case г = "г."
    case гП = "г.п."
    case д = "д."
    case кП = "к.п."
    case п = "п."
    case пП = "п.п."
    case рпто = "РПТО"
    case трасса = "трасса"
}

enum StreetType: String, Codable {
    case empty = ""
    case purpleПр = "пр"
    case streetTypeПр = "Пр."
    case streetTypeУл = "Ул."
    case the2ОйПер = "2-ой пер."
    case бул = "бул."
    case мкр = "мкр."
    case пл = "пл."
    case пр = "пр."
    case прТ = "пр-т"
    case просп = "просп."
    case ст = "ст."
    case ул = "ул."
    case шоссе = "шоссе"
}
