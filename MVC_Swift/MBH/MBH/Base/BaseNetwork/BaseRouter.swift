//
//  BaseRouter.swift
//
import Foundation
import SwiftyJSON
import Alamofire
import UIKit

enum SV_VT: NSInteger
{
    case Dump_SV
    case Live_SV
}
enum APIResult {
    case success(Any?, Any?)
    case failure(Any?)
    case timedOut()
    case networkError()
}

struct UploadFile: IApiUploadFile
{
    var data: Data! //Image data to upload
    var name:String! //name of key
    var fileName:String! //name of image file
    var mineType:String! //type of image. ex: "image/jpeg"
    
    func data() -> Data {
        return data
    }
    
    func name() -> String {
        return name
    }
    
    func fileName() -> String {
        return fileName
    }
    
    func mineType() -> String {
        return mineType
    }
    
    
}
extension BaseRouter
{
    func showNotConnect()
    {
        DispatchQueue.main.async {
            if(BaseRouter.enableAutomaticShowErrorOnVC)
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
class BaseRouter: IApi {
    static func timeOut() -> TimeInterval {
        switch(BaseRouter.SERVER)
        {
        case .Live_SV:
            return 300
        default:
            return 300
        }
    }
    
    func fullUrl() -> URL? {
        switch(BaseRouter.SERVER)
        {
        case .Dump_SV:
            return  URL.init(string: "\(baseUrlString())\(contextPathString())\(path())")
        case .Live_SV:
            return URL.init(string:"\(baseUrlString()):\(portString())\(contextPathString())\(path())")
        }
    }
    
    func baseUrlString() -> String {
        switch(BaseRouter.SERVER)
        {
        case .Dump_SV:
            return "https://vsmart-api.herokuapp.com"
        case .Live_SV:
            return "https://10.58.71.141"
        }
    }
    
    func contextPathString() -> String {
        switch(BaseRouter.SERVER)
        {
        case .Dump_SV:
            return "/api/"
        case .Live_SV:
            return "/api/"
        }
    }
    
    func portString() -> String {
        switch(BaseRouter.SERVER)
        {
        case .Dump_SV:
            return 8761.toString()
        case .Live_SV:
            return 8080.toString()
        }
    }
    
    func path() -> String {
        fatalError("[\(#function))] Must be overridden in subclass")
    }
    
    func method() -> IApiMethod {
        fatalError("[\(#function))] Must be overridden in subclass")
    }
    
    func parameters() -> [String : Any]? {
        fatalError("[\(#function))] Must be overridden in subclass")
    }
    
    func multipartBody() -> [Any]? {
        fatalError("[\(#function))] Must be overridden in subclass")
    }
    
    func parameterEncoding() -> Any {
        fatalError("[\(#function))] Must be overridden in subclass")
    }
    
    func headerFields() -> [String : String]? {
        fatalError("[\(#function))] Must be overridden in subclass")
    }
    
    func uploadFiles() -> [IApiUploadFile]? {
        fatalError("[\(#function))] Must be overridden in subclass")
    }
    
    func response(json: IApiOutput) -> Any? {
        fatalError("[\(#function))] Must be overridden in subclass")
    }
    
    
    
    static var SERVER:SV_VT = SV_VT.Dump_SV
    static var enableAutomaticShowErrorOnVC = true
    
    private let sessionManager: SessionManager = {
        var serverTrustPolicies: [String: ServerTrustPolicy]!
        switch(BaseRouter.SERVER)
        {
        case .Dump_SV:
            serverTrustPolicies = [
                "https://vsmart-api.herokuapp.com": .disableEvaluation,
                "vsmart-api.herokuapp.com": .disableEvaluation
            ]
            break
        case .Live_SV:
            serverTrustPolicies = [
                "https://vsmart-api.herokuapp.com": .disableEvaluation,
                "vsmart-api.herokuapp.com": .disableEvaluation
            ]
            break
            break
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = timeOut()
        configuration.timeoutIntervalForResource = timeOut()
        return SessionManager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
    }()
    
    var page: Int = 0
    var skip: Int = 0
    var limit: Int = 10
    
    // MARK: - Public methods
    func request(completed: ((APIResult) -> Void)?) {
        var response: APIResult = .networkError() {
            didSet {
                completed?(response)
            }
        }
        
        if(WIFI.isInternetAvailable() == false)
        {
            response = .networkError()
            self.showNotConnect()
            completed?(response)
            return
        }
        
        var isTimedOut: Bool = true
        DispatchQueue.main.asyncAfter(deadline: .now() + BaseRouter.timeOut()) {
            if isTimedOut {
                response = .timedOut()
                if(BaseRouter.enableAutomaticShowErrorOnVC)
                {
                    if let vc = self.getTopVC()
                    {
                        vc.showAlertControllerFromExtension(title: "Thông báo", message: "Máy chủ không phản hồi".localizedString(), okAction:{
                        })
                    }
                    
                }
            }
        }
        
        print("Request: \(fullUrl())")
        if let params = parameters() {
            print("Params: \(params)")
        }
        
        if let _ = uploadFiles() {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            sessionManager.upload(multipartFormData: { (form) in
                
                // Add images with multipartBody
                if var dataImages = self.uploadFiles() {
                    if dataImages.count < 5 {
                        let count = dataImages.count
                        for i in 1...(5 - count) {
                            let newIndex : Int = count + i
                            var file = UploadFile()
                            file.data = Data()
                            file.name = "image" + newIndex.toString()
                            file.fileName = file.name + ".jpeg"
                            file.mineType = "image/jpeg"
                            dataImages.append(file)
                        }
                    }
                    print("mutilpart data: \(dataImages)")
                    dataImages.forEach({ (file) in
                        form.append(file.data(), withName: file.name(), fileName: file.fileName(), mimeType: file.mineType())
                    })
                }
                
                if let parameters = self.parameters() {
                    for (key, value) in parameters {
                        if let valueString = value as? String {
                            form.append(valueString.data(using: .utf8)!, withName: key)
                        }
                    }
                }
            },usingThreshold:UInt64.init() , to: fullUrl()! as URLConvertible, method: method().methodType() , headers: headerFields(), encodingCompletion: { (result) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch result {
                case .success(let request, _, _):
                    request.responseJSON(completionHandler: { (responseObject) in
                        if let resultResponse = responseObject.response {
                            if let data = responseObject.data {
                                let json = try! JSON(data: data)
                                print("Status code: \(resultResponse.statusCode)")
                                print("Response json: \(json)")
                                var errMessageString: String?
                                var errorMessageString: String?
                                
                                if json["errMsg"].exists() {
                                    errMessageString = json["errMsg"].stringValue
                                    print("Message aaa: \(String(describing: errMessageString))")

                                    BaseLoading.hide(animated: true)
                                    
                                    let vc = self.getTopVC()
                                    vc?.showAlertControllerFromExtension(title: "Thông báo".localizedString(), message: errMessageString!, okAction: nil)
                                }else if json["errorMsg"].exists() {
                                    errorMessageString = json["errorMsg"].stringValue
                                    print("Message bbb: \(String(describing: errorMessageString))")

                                    BaseLoading.hide(animated: true)
                                    let vc = self.getTopVC()
                                    vc?.showAlertControllerFromExtension(title: "Thông báo".localizedString(), message: errorMessageString!, okAction: nil)
                                } else {
//
                                    switch resultResponse.statusCode {
                                    case 200, 201, 202, 203, 204:
                                        if let entity = self.response(json: json) {
                                            
                                            response = .success(entity, nil)
                                            
                                        } else {
                                            response = .failure(responseObject.result.error)
                                        }
                                        
                                    default:
                                        response = .failure(responseObject.result.error)
                                    }
                                }
                                
                            } else {
                                response = .failure(responseObject.result.error)
                            }
                        } else {
                            response = .networkError()
                            self.showNotConnect()
                        }
                    })
                    
                case.failure(_):
                    response = .networkError()
                    self.showNotConnect()
                }
            })
            
        } else {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            sessionManager.request(fullUrl() as URLConvertible , method: method().methodType() , parameters: parameters(), encoding: parameterEncoding(), headers: headerFields()).response { (result) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                isTimedOut = false
                if let resultResponse = result.response {
                    if let data = result.data {
                        let json = try! JSON(data: data)
                        print("Status code: \(resultResponse.statusCode)")
                        print("Response json: \(json)")
                        var errMessageString: String?
                        var errorMessageString: String?
                        var infoMessage : String?
                        if json["infoMsg"].exists() {
                            infoMessage = json["infoMsg"].stringValue
                            BaseLoading.hide(animated: true)
                            
                            let vc = self.getTopVC()
                            vc?.showAlertControllerFromExtension(title: "Thông báo".localizedString(), message: infoMessage!, okAction: {
                                NotificationCenter.default.post(name:Notification.Name("resetValue"), object: nil)
                                
                            })
                        }
                        if json["errMsg"].exists() {
                            
                            errMessageString = json["errMsg"].stringValue
                            response = .success(nil, nil)
                            print("Message aaa: \(String(describing: errMessageString))")
                            
                            BaseLoading.hide(animated: true)
                            
                            let vc = self.getTopVC()
                            vc?.showAlertControllerFromExtension(title: "Thông báo".localizedString(), message: errMessageString!, okAction: {
                                NotificationCenter.default.post(name:Notification.Name("resetValue"), object: nil)
                                
                            })
                        }else if json["errorMsg"].exists() {
                            
                            errorMessageString = json["errorMsg"].stringValue
                            response = .success(nil, nil)
                            print("Message bbb: \(String(describing: errorMessageString))")
                            
                            BaseLoading.hide(animated: true)
                            let vc = self.getTopVC()
                            vc?.showAlertControllerFromExtension(title: "Thông báo".localizedString(), message: errorMessageString!, okAction: {
                                NotificationCenter.default.post(name:Notification.Name("resetValue"), object: nil)
                              
                            })
                        } else {
                            //
                            switch resultResponse.statusCode {
                            case 200, 201, 202, 203, 204:
                                if let entity = self.response(json: json) {
                                    if let otherEntity = self.otherResponse(json: json) {
                                        response = .success(entity, otherEntity)
                                    } else {
                                        response = .success(entity, nil)
                                    }
                                } else {
                                    response = .failure(result.error)
                                }
                                
                            default:
                                response = .failure(result.error)
                            }
                        }
                    } else {
                        response = .failure(result.error)
                    }
                } else {
                    response = .networkError()
                    self.showNotConnect()
                }
            }
        }
    }
}
extension BaseRouter {
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
