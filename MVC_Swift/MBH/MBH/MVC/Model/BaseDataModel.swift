//
//  BaseDataModel.swift
//
import Foundation
import SwiftyJSON
import RealmSwift
import Realm

class BaseDataModel: NSObject, SwiftyJSONMappable {
    override init() {
        super.init()
    }
    
    required init?(byJSON json: JSON) {
        super.init()
        mapping(json: json)
    }
    
    required init?(byString string: String, key: String = "") {
        super.init()
        var json = string.toJSON()
        if !key.isEmpty { json = json[key] }
        mapping(json: json)
    }
    
    func mapping(json: JSON) {
    }
}


open class SwiftyJSONRealmObject: Object, SwiftyJSONMappable {
    
    required convenience public init?(byJSON json: JSON) {
        
        self.init()
        
    }
    required convenience public init?(byString string: String, key: String = "") {
        self.init()
        var json = string.toJSON()
        if !key.isEmpty { json = json[key] }
        mapping(json: json)
    }
    
    func mapping(json: JSON) {
    }
    
    open class func createList< T>(ofType type: T.Type, fromJson json: JSON) -> List<T> where T: SwiftyJSONRealmObject  {
        let list = List<T>()
        for (_, singleJson):(String, JSON) in json {
            if let model = T(byJSON: singleJson){
                list.append(model)
            }
        }
        
        return list
        
    }
    
}

