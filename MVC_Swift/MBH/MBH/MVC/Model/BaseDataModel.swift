//
//  BaseDataModel.swift
//
import Foundation
import SwiftyJSON
import RealmSwift
import Realm

class BaseDataModel: Object, SwiftyJSONMappable {
    static func setup(byJSON json: JSON) -> SwiftyJSONMappable? {
        let baseModel = self.init(byJSON: json)
        return baseModel
    }
    
    convenience init(byJSON json: JSON) {
        self.init()
        mapping(json: json)
    }
    
    convenience init(byString string: String, key: String = "") {
        self.init()
        var json = string.toJSON()
        if !key.isEmpty { json = json[key] }
        mapping(json: json)
    }
    
    func mapping(json: JSON) {
    }
    
}


