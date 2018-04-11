//
//  BaseDataModel.swift
//

import SwiftyJSON

class BaseDataModel: NSObject, SwiftyJSONMappable {
    
    var objectId: String?
    var key: String?
    var message: String?
    var errorMessage: String?
    var infoMsg : String?
    var errorCode : Int?
    var statusMsg : String?
    
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
        if json.type == .null {
            return
        }
        
        if json["key"].exists() {
            key = json["key"].stringValue
        }
        
        if json["message"].exists() {
            message = json["message"].stringValue
        }
        
        if json["errorMsg"].exists() {
            errorMessage = json["errorMsg"].stringValue
        }
        
        if json["infoMsg"].exists() {
            infoMsg = json["infoMsg"].stringValue
        }
        
        if json["status"].exists() {
            statusMsg = json["status"].stringValue
        }
        
        if json["errorCode"].exists() {
            errorCode = json["errorCode"].intValue
        }
    }
}
