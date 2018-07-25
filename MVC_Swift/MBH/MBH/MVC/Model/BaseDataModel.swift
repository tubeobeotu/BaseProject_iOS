//
//  BaseDataModel.swift
//
import Foundation
import SwiftyJSON
import RealmSwift
import Realm

class BaseDataModel: Object, JSONMappable {
    static func setup(byJSON json: IJSON) -> JSONMappable? {
        let baseModel = self.init(byJSON: json)
        return baseModel
    }
    
    convenience init(byJSON json: IJSON) {
        self.init()
        mapping(json: json)
    }
    
//    convenience init(byString string: String, key: String = "") {
//        self.init()
//        var json = string.toJSON()
//        if !key.isEmpty { json = json. }
//        mapping(json: json)
//    }
    
    func mapping(json: IJSON) {
    }
    
}


