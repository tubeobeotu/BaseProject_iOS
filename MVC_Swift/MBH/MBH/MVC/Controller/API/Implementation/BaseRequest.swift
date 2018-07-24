//
//  BaseRequest.swift
//  MBH
//
//  Created by tunv on 7/24/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
class BaseRequest {
    var handleExpireToken = true
    static var SERVER:SV_VT = SV_VT.Live_SV
    static var enableAutomaticShowErrorOnVC = true
    
    static func timeOut() -> TimeInterval {
        switch(BaseRequest.SERVER)
        {
        case .Live_SV:
            return ServerConfig.requestTimeoutLiveServer
        default:
            return ServerConfig.requestTimeoutTestServer
        }
    }
    
    private let sessionManager: SessionManager = {
        var serverTrustPolicies: [String: ServerTrustPolicy]!
        switch(BaseRequest.SERVER)
        {
        case .Dump_SV:
            serverTrustPolicies = [
                ServerConfig.serverUrlTest: .disableEvaluation
            ]
            break
        case .Live_SV:
            serverTrustPolicies = [
                ServerConfig.serverUrlLive: .disableEvaluation
                //                "vsmart-api.herokuapp.com": .disableEvaluation
            ]
            break
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = timeOut()
        configuration.timeoutIntervalForResource = timeOut()
        return SessionManager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
    }()
    // MARK: - Public methods
    func request(requestObject: IApi, completed: ((APIResult) -> Void)?) {
        var response: APIResult = .networkError(EZError.setupNotInternet() as IError) {
            didSet {
                completed?(response)
            }
        }
        
        if(WIFI.isInternetAvailable() == false)
        {
            response = .networkError(EZError.setupNotInternet() as IError)
            self.showNotConnect()
            completed?(response)
            return
        }
        
        var isTimedOut: Bool = true
        DispatchQueue.main.asyncAfter(deadline: .now() + BaseRequest.timeOut()) {
            if isTimedOut {
                response = .timedOut(EZError.setupRequestTimeout() as IError)
                if(BaseRequest.enableAutomaticShowErrorOnVC)
                {
                    if let vc = self.getTopVC()
                    {
                        vc.showAlertControllerFromExtension(title: "Thông báo", message: "Máy chủ không phản hồi".localizedString(), okAction:{
                        })
                    }
                    
                }
            }
        }
        
        print("Request: \(requestObject.fullUrl()!.absoluteString)")
        if let params = requestObject.parameters() {
            print("Params: \(params)")
        }
        
        
        if(handleExpireToken == true){
            let handle = OAuth2Handler.init(clientID: OAuth.clientId, baseURLString: "\(requestObject.baseUrlString()):\(requestObject.portString())", accessToken: Token.share.accessToken, refreshToken: Token.share.refreshToken)
            self.sessionManager.adapter = handle
            self.sessionManager.retrier = handle
        }else{
            handleExpireToken = true
        }
        
        if let _ = requestObject.uploadFiles() {
            //request multiple parts
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            sessionManager.upload(multipartFormData: { (form) in
                // Add images with multipartBody
                if var dataImages = requestObject.uploadFiles() {
                    if dataImages.count > 0 {
                        let count = dataImages.count
                        for i in 0..<count {
                            let newIndex : Int = count + i
                            var file = UploadFile()
                            file._data = Data()
                            file._name = "image" + newIndex.toString()
                            file._fileName = file._name + ".jpeg"
                            file._mineType = "image/jpeg"
                            dataImages.append(file)
                        }
                    }
                    print("mutilpart data: \(dataImages)")
                    dataImages.forEach({ (file) in
                        form.append(file.data(), withName: file.name(), fileName: file.fileName(), mimeType: file.mineType())
                    })
                }
                
                if let parameters = requestObject.parameters() {
                    for (key, value) in parameters {
                        if let valueString = value as? String {
                            form.append(valueString.data(using: .utf8)!, withName: key)
                        }
                    }
                }
            },usingThreshold:UInt64.init() , to: requestObject.fullUrl()! as URLConvertible, method:requestObject.method().methodType(), headers: requestObject.headerFields(), encodingCompletion: { (result) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch result {
                case .success(let request, _, _):
                    request.responseJSON(completionHandler: { (responseObject) in
                        if let resultResponse = responseObject.response {
                            if let data = responseObject.data {
                                let output = ApiOutput(data: data)
                                print("Status code: \(resultResponse.statusCode)")
                                switch resultResponse.statusCode {
                                case 200, 201, 202, 203, 204:
                                    if let entity = requestObject.response(data: output) {
                                        response = .success(entity, nil)
                                        
                                    } else {
                                        let content = String(data: data, encoding: String.Encoding.utf8)
                                        let customError = EZError.init(title: "Error", description: content ?? "", code: resultResponse.statusCode)
                                        response = .failure(customError)
                                    }
                                    
                                default:
                                    let content = String(data: data, encoding: String.Encoding.utf8)
                                    let customError = EZError.init(title: "Error", description: content ?? "", code: resultResponse.statusCode)
                                    response = .failure(customError)
                                }
                            } else {
                                let customError = EZError.init(error: responseObject.result.error)
                                response = .failure(customError)
                            }
                        } else {
                            response = .networkError(EZError.setupNotInternet() as IError)
                            self.showNotConnect()
                        }
                    })
                    
                case.failure(_):
                    response = .networkError(EZError.setupNotInternet() as IError)
                    self.showNotConnect()
                }
            })
        } else {
            //normal request
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let method = requestObject.method().methodType()
            let params = requestObject.parameters()
            let encoding = requestObject.parameterEncoding()
            let header = requestObject.headerFields()
            let url = requestObject.fullUrl()
            
            sessionManager.request(url!, method: method, parameters: params, encoding: encoding as! ParameterEncoding, headers: header).response { (result) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                isTimedOut = false
                if let resultResponse = result.response {
                    if let data = result.data {
                        let output = ApiOutput(data: data)
                        print("Status code: \(resultResponse.statusCode)")
                        switch resultResponse.statusCode {
                        case 200, 201, 202, 203, 204:
                            if let entity = requestObject.response(data: output) {
                                response = .success(entity, nil)
                            } else {
                                let content = String(data: data, encoding: String.Encoding.utf8)
                                let customError = EZError.init(title: "Error", description: content ?? "", code: resultResponse.statusCode)
                                response = .failure(customError)
                            }
                            
                        default:
                            let content = String(data: data, encoding: String.Encoding.utf8)
                            let customError = EZError.init(title: "Error", description: content ?? "", code: resultResponse.statusCode)
                            response = .failure(customError)
                        }
                        
                    } else {
                        let customError = EZError.init(error: result.error)
                        response = .failure(customError)
                    }
                } else {
                    response = .networkError(EZError.setupNotInternet() as IError)
                    self.showNotConnect()
                }
            }
        }
    }
}
extension BaseRequest {
    func getTopVC() -> UIViewController?
    {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
}

extension BaseRequest
{
    func showNotConnect()
    {
        DispatchQueue.main.async {
            if(BaseRequest.enableAutomaticShowErrorOnVC)
            {
                if let vc = self.getTopVC()
                {
                    vc.showAlertControllerFromExtension(title: "Thông báo".localizedString(), message: "Không có kết nối".localizedString(), okAction:{
                    })
                }
                
            }
        }
    }
}


class OAuth2Handler: RequestAdapter, RequestRetrier {
    private typealias RefreshCompletion = (_ succeeded: Bool, _ token: Token?) -> Void
    
    private let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        return SessionManager(configuration: configuration)
    }()
    
    private let lock = NSLock()
    
    private var clientID: String
    private var baseURLString: String
    private var accessToken: String
    private var refreshToken: String
    
    private var isRefreshing = false
    private var requestsToRetry: [RequestRetryCompletion] = []
    
    // MARK: - Initialization
    
    public init(clientID: String, baseURLString: String, accessToken: String, refreshToken: String) {
        self.clientID = clientID
        self.baseURLString = baseURLString
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
    // MARK: - RequestAdapter
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(baseURLString) {
            var urlRequest = urlRequest
            urlRequest.setValue(Token.share.type + " " + accessToken, forHTTPHeaderField: "Authorization")
            return urlRequest
        }
        
        return urlRequest
    }
    
    // MARK: - RequestRetrier
    
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        lock.lock() ; defer { lock.unlock() }
        
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            requestsToRetry.append(completion)
            
            if !isRefreshing {
                refreshTokens { [weak self] succeeded, token in
                    guard let strongSelf = self else { return }
                    
                    strongSelf.lock.lock() ; defer { strongSelf.lock.unlock() }
                    strongSelf.requestsToRetry.forEach { $0(succeeded, 0.0) }
                    strongSelf.requestsToRetry.removeAll()
                    if let accessToken = token?.accessToken, let refreshToken = token?.refreshToken {
                        strongSelf.accessToken = accessToken
                        strongSelf.refreshToken = refreshToken
                    }else{
//                        AppObject.shared.logOut()
                    }
                    
                    
                    
                }
            }
        } else {
            completion(false, 0.0)
        }
    }
    
    // MARK: - Private - Refresh Tokens
    
    private func refreshTokens(completion: @escaping RefreshCompletion) {
        guard !isRefreshing else { return }
        
        isRefreshing = true
        
        let urlString = "\(baseURLString)/oauth/token"
        
        let parameters: [String: Any] = [
            "access_token": accessToken,
            "refresh_token": refreshToken,
            "client_id": clientID,
            "grant_type": "refresh_token"
        ]
        let credentialData = "\(OAuth.clientId):\(OAuth.clientSecret)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let header = ["Authorization": "Basic \(base64Credentials)", "Content-Type" : "application/x-www-form-urlencoded"]
        sessionManager.request(urlString, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: header)
            .responseJSON { [weak self] response in
                guard let strongSelf = self else { return }
                let middleApi = MiddleApi<Token>()
                if
                    let json = response.data
                {
                    let token = middleApi.getModel(json: json)
                    if(token.accessToken != ""){
                        Token.share.setObject(token: token)
                        AppObject.shared.userInfo.accessToken = token.accessToken
                        AppObject.shared.userInfo.refreshToken = token.refreshToken
                        AppObject.shared.userInfo.tokenType = token.type
                        completion(true, token)
                    }else {
                        completion(false, nil)
                    }
                    
                } else {
                    completion(false, nil)
                }
                
                strongSelf.isRefreshing = false
        }
    }
}
