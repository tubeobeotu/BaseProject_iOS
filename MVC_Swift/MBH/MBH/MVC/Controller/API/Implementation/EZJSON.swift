//
//  EZJSON.swift
//  MBH
//
//  Created by tunv on 7/25/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation
import SwiftyJSON
public enum JSONType : Int {
    
    case number
    
    case string
    
    case bool
    
    case array
    
    case dictionary
    
    case null
    
    case unknown
}

struct EZJSON: IJSON{
    private var json: JSON!
    mutating func setJSON(json: Data) {
        self.json = try! JSON.init(data: json)
    }
    
    func getType() -> JSONType {
        return JSONType.init(rawValue: self.json.type.rawValue) ?? .null
    }
    
    func getArrayValues() -> [IJSON] {
        var result = [IJSON]()
        if(self.getType() != .null){
            if(self.getType() == .array){
                for tmpJson in self.json.arrayValue{
                    let ijson = EZJSON.init(json: tmpJson)
                    result.append(ijson)
                }
            }else{
                let ijson = EZJSON.init(json: self.json)
                result.append(ijson)
            }
            
        }
        
        return result
    }
    
    func getStringValue(key: String) -> String {
        if(json[key].exists()){
            return json[key].stringValue
        }
        return ""
    }
    
    func getBoolValue(key: String) -> Bool {
        if(json[key].exists()){
            return json[key].boolValue
        }
        return false
    }
    
    func getIntValue(key: String) -> Int {
        if(json[key].exists()){
            return json[key].intValue
        }
        return 0
    }
    
    func getFloatValue(key: String) -> Float {
        if(json[key].exists()){
            return json[key].floatValue
        }
        return 0
    }
    
    
}
