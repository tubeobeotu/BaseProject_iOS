//
//  ApiLoginCaller.swift
//  MBH
//
//  Created by tunv on 7/24/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation
//completed: ((APICallerResult) -> Void)?
class ApiLoginCaller: BaseCaller {
    var request = BaseRequest()
    func login<T>(type: T.Type, username: String, password: String, grantType: String = "password", completed: ((APICallerResult<T>) -> Void)?){
        request.handleExpireToken = false
        let router = ApiLoginRouter.init(endpoint: .login(username: username, password: password, grantType: grantType))
        request.request(requestObject: router) { (result) in
            completed?(self.handleResult(input: result) as APICallerResult<T>)
        }
    }
    func getUserInfo(){
    }
    func changePassword(password: String, newPassword: String){
    }
}


