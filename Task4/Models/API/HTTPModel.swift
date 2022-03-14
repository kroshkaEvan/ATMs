//
//  HTTPModel.swift
//  Task4
//
//  Created by Эван Крошкин on 27.03.22.
//

import Foundation

enum HTTPMethod: String {
    case get
    case post
    case put
    case patch
    case delete

    var name: String {
        return self.rawValue.uppercased()
    }
}

enum HTTPHeader: String {
    case contentType = "Content-Type"
}

enum HTTPHeaderValue: String {
    case json = "application/json; charset=utf-8"
}
