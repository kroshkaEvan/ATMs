//
//  Service.swift
//  Task4
//
//  Created by Эван Крошкин on 27.03.22.
//

import Foundation

struct Service: Codable {
    let serviceType: ServiceType
    let serviceDescription: ServiceDescription

    enum CodingKeys: String, CodingKey {
        case serviceType
        case serviceDescription = "description"
    }
}

struct Accessibilities: Codable {
    let accessibility: [Service]

    enum CodingKeys: String, CodingKey {
        case accessibility = "Accessibility"
    }
}

enum ServiceDescription: String, Codable {
    case cashByCode = "CashByCode"
    case cashByCodeINF = "CashByCode, INF"
    case empty = ""
    case толькоПоКарточкамБанковРезидентов = "Только по карточкам банков-резидентов"
    case толькоПоКарточкамОАОАСББеларусбанк = "Только по карточкам ОАО \"АСБ Беларусбанк\""
}

enum ServiceType: String, Codable {
    case audioCashMachine = "AudioCashMachine"
    case balance = "Balance"
    case billPayments = "BillPayments"
    case braille = "Braille"
    case cashIn = "CashIn"
    case cashWithdrawal = "CashWithdrawal"
    case miniStatement = "MiniStatement"
    case other = "Other"
    case pinActivation = "PINActivation"
    case pinChange = "PINChange"
    case pinUnblock = "PINUnblock"
}
