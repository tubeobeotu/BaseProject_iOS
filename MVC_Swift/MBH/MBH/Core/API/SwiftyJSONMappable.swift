//
//  SwiftyJSONMappable.swift
//

import SwiftyJSON
import Foundation
protocol SwiftyJSONMappable {
    static func setup(byJSON json: JSON) -> SwiftyJSONMappable?
}

extension Array where Element: SwiftyJSONMappable {
    
    init(byJSON json: JSON) {
        self.init()
        if json.type == .null { return }
        var tmpArray = [SwiftyJSONMappable]()
        for item in json.arrayValue {
            if let object = Element.setup(byJSON: item) {
                tmpArray.append(object)
            }
        }
        self = tmpArray as! Array<Element>
    }
    
    init(byString string: String, key: String = "") {
        self.init()
        var json = string.toJSON()
        if !key.isEmpty { json = json[key] }
        if json.type == .null { return }
        
        var tmpArray = [SwiftyJSONMappable]()
        for item in json.arrayValue {
            if let object = Element.setup(byJSON: item) {
                tmpArray.append(object)
            }
        }
        self = tmpArray as! Array<Element>
    }
}

extension String {

    func toJSON() -> JSON {
        return self.data(using: String.Encoding.utf8).flatMap({try! JSON(data: $0)}) ??  JSON(NSNull())
    }
}
