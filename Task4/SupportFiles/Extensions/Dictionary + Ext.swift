//
//  Dictionary + Ext.swift
//  Task4
//
//  Created by Эван Крошкин on 1.03.22.
//

import Foundation

extension Dictionary where Value: RangeReplaceableCollection {
    mutating func append(element: Value.Iterator.Element, toValueOfKey key: Key) {
        var value: Value = self[key] ?? Value()
        value.append(element)
        self[key] = value
    }
}
