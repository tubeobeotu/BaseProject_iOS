//
//  EZTokenModel.swift
//  Checking
//
//  Created by Tu NV on 6/14/18.
//  Copyright © 2018 Tu NV. All rights reserved.
//

import Foundation
import SwiftyJSON
class EZTokenModel: BaseDataModel, ILocalModel{
    static let share = EZTokenModel()
    var accessToken = ""
    var refreshToken = ""
    var type = ""
    var expiresIn = ""
    var scope = ""
    
    override func mapping(json: IJSON) {
        super.mapping(json: json)
      
        accessToken =  json.getStringValue(key: "access_token")
        refreshToken = json.getStringValue(key: "refresh_token")
        type =  json.getStringValue(key: "token_type")
        expiresIn =  json.getStringValue(key: "expires_in")
        scope =  json.getStringValue(key: "scope")
    }
    
    func setObject(token: EZTokenModel){
        self.accessToken = token.accessToken
        self.refreshToken = token.refreshToken
        self.type = token.type
        self.expiresIn = token.expiresIn
        self.scope = token.scope
        
        ///
        
    }
    
    func getLocalId() -> String {
        return "0"
    }
}
