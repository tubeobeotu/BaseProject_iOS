//
//  SwiftyJSONMappable.swift
//

import SwiftyJSON

protocol SwiftyJSONMappable {
    init?(byJSON json: JSON)
//    init?(byString string: String, key: String)
}

extension Array where Element: SwiftyJSONMappable {
    
    init(byJSON json: JSON) {
        self.init()
        if json.type == .null { return }
        
        for item in json.arrayValue {
            if let object = Element.init(byJSON: item) {
                self.append(object)
            }
        }
    }
    
    init(byString string: String, key: String = "") {
        self.init()
        var json = string.toJSON()
        if !key.isEmpty { json = json[key] }
        if json.type == .null { return }
        
        for item in json.arrayValue {
            if let object = Element.init(byJSON: item) {
                self.append(object)
            }
        }
    }
}

extension String {

    func toJSON() -> JSON {
        return self.data(using: String.Encoding.utf8).flatMap({JSON(data: $0)}) ?? JSON(NSNull())
    }
}
