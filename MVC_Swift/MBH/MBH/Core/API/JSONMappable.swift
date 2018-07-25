//
//  JSONMappable.swift
//

import SwiftyJSON
import Foundation
protocol JSONMappable {
    static func setup(byJSON json: IJSON) -> JSONMappable?
}
extension Array where Element: JSONMappable {
    
    init(byJSON json: IJSON) {
        self.init()
        if json.getType() == .null { return }
        var tmpArray = [JSONMappable]()
        for item in json.getArrayValues() {
            if let object = Element.setup(byJSON: item) {
                tmpArray.append(object)
            }
        }
        self = tmpArray as! Array<Element>
    }
    
//    init(byString string: String, key: String = "") {
//        self.init()
//        var json = string.toJSON()
//        if !key.isEmpty { json = json[key] }
//        if json.type == .null { return }
//        
//        var tmpArray = [JSONMappable]()
//        for item in json.arrayValue {
//            if let object = Element.setup(byJSON: item) {
//                tmpArray.append(object)
//            }
//        }
//        self = tmpArray as! Array<Element>
//    }
}

extension String {
    
//    func toJSON() -> IJSON {
//        return self.data(using: String.Encoding.utf8).flatMap({try! JSON(data: $0)}) ??  JSON(NSNull())
//    }
}
