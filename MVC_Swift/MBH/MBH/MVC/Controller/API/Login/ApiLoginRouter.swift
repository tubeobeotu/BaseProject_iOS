//
//  ApiLoginRouter.swift
//  MBH
//
//  Created by tunv on 7/24/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation
import Alamofire
enum EZLoginEnpoint {
    case login(username: String, password: String, grantType: String)
    case getUserInfo()
    case changePassword(password: String, newPassword: String)
}

class ApiLoginRouter: BaseRouter, IApi{
    var endpoint: EZLoginEnpoint
    init(endpoint: EZLoginEnpoint) {
        self.endpoint = endpoint
    }
    
    func showLoading() -> Bool {
        return true
    }
    override func path() -> String {
        switch endpoint {
        case .login(_, _, _):
            return "/oauth/token"
        case .getUserInfo():
            return "/user/me"
        case .changePassword(_, _):
            return "/user/password/change"
        }
    }
    
    override func method() -> IApiMethod {
        switch self.endpoint {
        case .login(_, _, _):
            return ApiPostMethod()
        case .changePassword(_, _):
            return ApiPutMethod()
        default:
            return ApiGetMethod()
        }
    }
    
    override  func parameters() -> [String : Any]? {
        var params = [String: Any]()
        switch endpoint {
        case .login(let username, let password, let grantType):
            params["username"] = username
            params["password"] = password
            params["grant_type"] = grantType
            break
        case .changePassword(let password, let newPassword):
            params["password"] = password
            params["newPassword"] = newPassword
        case .getUserInfo:
            break
        }
        return params
    }
    
    override func contextPathString() -> String  {
        switch self.endpoint {
        case .getUserInfo(), .changePassword(_,  _):
            return "/api"
        default:
            return ""
        }
    }
    
    override  func parameterEncoding() -> Any {
        switch self.endpoint {
        case  .changePassword(_,  _):
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
    
    override func headerFields() -> [String: String]? {
        switch self.endpoint {
        case  .changePassword(_,  _):
            return ["Content type" : "application/json"]
        default:
            let credentialData = "\(OAuth.clientId):\(OAuth.clientSecret)".data(using: String.Encoding.utf8)!
            let base64Credentials = credentialData.base64EncodedString(options: [])
            return ["Authorization": "Basic \(base64Credentials)", "Content-Type" : "application/x-www-form-urlencoded", "Accept" : "application/json"]
        }
        
    }
    
    override  func response(data: IApiOutput) -> Any? {
        switch self.endpoint {
        case .login(_, _, _):
           return MiddleApi<Token>().getModel(json: data.getRespose())
        default:
            return MiddleApi<BaseDataModel>().getModel(json: data.getRespose())
        }
    }
    
    
}
