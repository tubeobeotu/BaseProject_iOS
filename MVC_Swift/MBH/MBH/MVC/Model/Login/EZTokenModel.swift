//
//  EZTokenModel.swift
//  Checking
//
//  Created by Tu NV on 6/14/18.
//  Copyright © 2018 Tu NV. All rights reserved.
//

import Foundation
import SwiftyJSON
class Token: BaseDataModel{
    static let share = Token()
    var accessToken = ""
    var refreshToken = ""
    var type = ""
    var expiresIn = ""
    var scope = ""
    
    override func mapping(json: JSON) {
        super.mapping(json: json)
        if json["access_token"].exists() {
            accessToken = json["access_token"].stringValue
        }
        
        if json["refresh_token"].exists() {
            refreshToken = json["refresh_token"].stringValue
        }
        
        if json["token_type"].exists() {
            type = json["token_type"].stringValue
        }
        
        if json["expires_in"].exists() {
            expiresIn = json["expires_in"].stringValue
        }
        
        if json["scope"].exists() {
            scope = json["scope"].stringValue
        }
    }
    
    func setObject(token: Token){
        self.accessToken = token.accessToken
        self.refreshToken = token.refreshToken
        self.type = token.type
        self.expiresIn = token.expiresIn
        self.scope = token.scope
        
        ///
        
    }
}
