//
//  IJON.swift
//  MBH
//
//  Created by tunv on 7/25/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation
protocol IJSON{
    mutating func setJSON(json: Data)
    func getType() -> JSONType
    func getArrayValues() -> [IJSON]
    func getStringValue(key: String) -> String
    func getBoolValue(key: String) -> Bool
    func getIntValue(key: String) -> Int
    func getFloatValue(key: String) -> Float
    func getArrayJSON(key: String) -> [IJSON]
    func getJSON(key: String) -> IJSON
}
