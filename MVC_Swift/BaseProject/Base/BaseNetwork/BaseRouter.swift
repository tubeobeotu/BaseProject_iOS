//
//  BaseRouter.swift
//

import Alamofire
import SwiftyJSON
import KVLoading

enum SV_VT: NSInteger
{
    case Dump_SV        //SV Anh Nam
    case VT_SV          //SV VT42
    case VT_Global_SV   //SV VT42 camcpuchia dump
    case Global_SV      //SV Campuchia
    case VT_SV_A_Quang //10.61.138.207:8084
}
enum APIResult {
    case success(Any?, Any?)
    case failure(Any?)
    case timedOut()
    case networkError()
}

struct UploadFile
{
    var data: Data! //Image data to upload
    var name:String! //name of key
    var fileName:String! //name of image file
    var mineType:String! //type of image. ex: "image/jpeg"
}
extension BaseRouter
{
    func showNotConnect()
    {
        DispatchQueue.main.async {
            if(BaseRouter.enableAutomaticShowErrorOnVC && !BroadCastNewInfoModel.sharedInstance.isAddErrorMessage)
            {
                if let vc = self.getTopVC()
                {
                    BroadCastNewInfoModel.sharedInstance.isAddErrorMessage = true
                    vc.showAlertControllerFromExtension(title: "Thông báo".localizedString(), message: "Không có kết nối".localizedString(), okAction:{
                        BroadCastNewInfoModel.sharedInstance.isAddErrorMessage = false
                    })
                }
                
            }
        }
    }
}
class BaseRouter {
    static var SERVER:SV_VT = SV_VT.Dump_SV
    static var enableAutomaticShowErrorOnVC = true
    
    static var timeOut: TimeInterval {
        get {
            switch(BaseRouter.SERVER)
            {
            case .VT_SV:
                return 300
            default:
                return 300
            }
        }
    }
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
        case .VT_SV:
            serverTrustPolicies = [
                "https://10.58.71.141": .disableEvaluation,
                "10.58.71.141": .disableEvaluation
            ]
            break
        case .VT_Global_SV:
            serverTrustPolicies = [
                "http://10.60.7.189": .disableEvaluation,
                "10.60.7.189": .disableEvaluation
//                "http://10.61.138.207": .disableEvaluation,
//                "10.61.38.207": .disableEvaluation
            ]
            break
        case .Global_SV:
            serverTrustPolicies = [
                "https://vsmart.vtnet.viettel.vn": .disableEvaluation,
                "vsmart.vtnet.viettel.vn": .disableEvaluation
            ]
            break
            
        case .VT_SV_A_Quang:
            serverTrustPolicies = [
                "http://10.61.138.207": .disableEvaluation,
                "10.61.138.207": .disableEvaluation
            ]
            break
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = timeOut
        configuration.timeoutIntervalForResource = timeOut
        return SessionManager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
    }()
    
    let sessionLongTaskManager: SessionManager = {
        var serverTrustPolicies: [String: ServerTrustPolicy]!
        switch(BaseRouter.SERVER)
        {
        case .Dump_SV:
            serverTrustPolicies = [
                "https://vsmart-api.herokuapp.com": .disableEvaluation,
                "vsmart-api.herokuapp.com": .disableEvaluation
            ]
            break
        case .VT_SV:
            serverTrustPolicies = [
                "https://10.58.71.141": .disableEvaluation,
                "10.58.71.141": .disableEvaluation
            ]
            break
        case .VT_Global_SV:
            serverTrustPolicies = [
                "http://10.60.7.189": .disableEvaluation,
                "10.60.7.189": .disableEvaluation
//                "http://10.61.138.207": .disableEvaluation,
//                "10.61.38.207": .disableEvaluation
            ]
            break
        case .Global_SV:
            serverTrustPolicies = [
                "https://vsmart.vtnet.viettel.vn": .disableEvaluation,
                "vsmart.vtnet.viettel.vn": .disableEvaluation
            ]
            break
            
        case .VT_SV_A_Quang:
            serverTrustPolicies = [
                "http://10.61.138.207": .disableEvaluation,
                "10.61.138.207": .disableEvaluation
            ]
            break
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 10 * timeOut
        configuration.timeoutIntervalForResource = 10 * timeOut
        return SessionManager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
    }()
    
    private var fullURL: URLConvertible {
        switch(BaseRouter.SERVER)
        {
        case .Dump_SV:
            return  URL.init(string: "\(baseURLString)\(contextPathString)\(path)")!
        case .VT_SV, .VT_SV_A_Quang:
            return URL.init(string:"\(baseURLString):\(basePORTString)\(contextPathString)\(path)")!
        case .VT_Global_SV:
            return URL.init(string:"\(baseURLString):\(basePORTString)\(contextPathString)\(path)")!
        case .Global_SV:
            return URL.init(string:"\(baseURLString):\(basePORTString)\(contextPathString)\(path)")!
        }
    }
    
    var baseURLString: String {
        switch(BaseRouter.SERVER)
        {
        case .Dump_SV:
            return "https://vsmart-api.herokuapp.com"
        case .VT_SV:
            return "https://10.58.71.141"
        case .VT_Global_SV:
            return "http://10.60.7.189"
//            return "http://10.61.138.207"
        case .Global_SV:
            return "https://vsmart.vtnet.viettel.vn"
            
        case .VT_SV_A_Quang:
            return "http://10.61.138.207"
        }
    }
    
    var contextPathString: String {
        switch(BaseRouter.SERVER)
        {
        case .Dump_SV:
            return "/api/"
        case .VT_SV:
            return "/VSMART_MAIN_CODE_FULL/"
           // return "/QLCTKT/"
        case .VT_Global_SV:
            return "/QLCTKT/"
        case .Global_SV:
            return "/QLCTKT/"
        case .VT_SV_A_Quang:
            return "/QLCTKT/"
        }
    }
    
    var basePORTString: UInt16 {
        switch(BaseRouter.SERVER)
        {
        case .Dump_SV:
            return 8761
        case .VT_SV:
            return 9123
          //  return 9310
        case .VT_Global_SV:
            return 8154
//            return 8084
        case .Global_SV:
            return 8443
            
        case .VT_SV_A_Quang:
            return 8084
        }
    }
    
    var path: String {
        fatalError("[\(#function))] Must be overridden in subclass")
    }
    
    var method: HTTPMethod {
        fatalError("[\(#function))] Must be overridden in subclass")
    }
    
    var parameters: [String: Any]? {
        fatalError("[\(#function))] Must be overridden in subclass")
    }
    
    var multipartBody: [MultipartFormData]? {
        fatalError("[\(#function))] Must be overridden in subclass")
    }
    
    var parameterEncoding: ParameterEncoding {
        fatalError("[\(#function))] Must be overridden in subclass")
    }
    
    var headerFields: [String: String]? {
        fatalError("[\(#function))] Must be overridden in subclass")
//        guard let currentUser = LocalUser.shared.currentUser else {
//            return nil
//        }
//        let userToken = currentUser.userToken ?? "userToken"
//        let username = currentUser.username ?? "username"
//        return ["token": userToken, "username": username]
    }

    var uploadFiles: [UploadFile]? {
        fatalError("[\(#function))] Must be overridden in subclass")
    }
    
    func response(json: JSON) -> Any? {
        fatalError("[\(#function))] Must be overridden in subclass")
    }
    
    func otherResponse(json: JSON) -> Any? {
        fatalError("[\(#function))] Must be overridden in subclass")
    }
    
    func errorResponse(json: JSON) -> Any? {
        fatalError("[\(#function))] Must be overridden in subclass")
    }
    
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
        DispatchQueue.main.asyncAfter(deadline: .now() + BaseRouter.timeOut) {
            if isTimedOut {
                response = .timedOut()
                if(BaseRouter.enableAutomaticShowErrorOnVC && !BroadCastNewInfoModel.sharedInstance.isAddErrorMessage)
                {
                    if let vc = self.getTopVC()
                    {
                        BroadCastNewInfoModel.sharedInstance.isAddErrorMessage = true
                        vc.showAlertControllerFromExtension(title: "Thông báo", message: "Máy chủ không phản hồi".localizedString(), okAction:{
                            BroadCastNewInfoModel.sharedInstance.isAddErrorMessage = false
                        })
                    }
                    
                }
            }
        }
        
        print("Request: \(fullURL)")
        if let params = parameters {
            print("Params: \(params)")
        }
        
        if let _ = uploadFiles {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            sessionManager.upload(multipartFormData: { (form) in
                
                // Add images with multipartBody
                if var dataImages = self.uploadFiles {
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
                        form.append(file.data, withName: file.name, fileName: file.fileName, mimeType: file.mineType)
                    })
                }
                
                if let parameters = self.parameters {
                    for (key, value) in parameters {
                        if let valueString = value as? String {
                            form.append(valueString.data(using: .utf8)!, withName: key)
                        }
                    }
                }
            },usingThreshold:UInt64.init() , to: fullURL, method: method, headers: headerFields, encodingCompletion: { (result) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch result {
                case .success(let request, _, _):
                    request.responseJSON(completionHandler: { (responseObject) in
                        if let resultResponse = responseObject.response {
                            if let data = responseObject.data {
                                let json = JSON(data: data)
                                print("Status code: \(resultResponse.statusCode)")
                                print("Response json: \(json)")
                                var errMessageString: String?
                                var errorMessageString: String?
                                
                                if json["errMsg"].exists() {
                                    errMessageString = json["errMsg"].stringValue
                                    print("Message aaa: \(String(describing: errMessageString))")

                                    KVLoading.hide(animated: true)
                                    
                                    let vc = self.getTopVC()
                                    vc?.showAlertControllerFromExtension(title: "Thông báo".localizedString(), message: errMessageString!, okAction: nil)
                                }else if json["errorMsg"].exists() {
                                    errorMessageString = json["errorMsg"].stringValue
                                    print("Message bbb: \(String(describing: errorMessageString))")

                                    KVLoading.hide(animated: true)
                                    let vc = self.getTopVC()
                                    vc?.showAlertControllerFromExtension(title: "Thông báo".localizedString(), message: errorMessageString!, okAction: nil)
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
            sessionManager.request(fullURL, method: method, parameters: parameters, encoding: parameterEncoding, headers: headerFields).response { (result) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                isTimedOut = false
                if let resultResponse = result.response {
                    if let data = result.data {
                        let json = JSON(data: data)
                        print("Status code: \(resultResponse.statusCode)")
                        print("Response json: \(json)")
                        var errMessageString: String?
                        var errorMessageString: String?
                        var infoMessage : String?
                        if json["infoMsg"].exists() {
                            infoMessage = json["infoMsg"].stringValue
                            KVLoading.hide(animated: true)
                            
                            let vc = self.getTopVC()
                            vc?.showAlertControllerFromExtension(title: "Thông báo".localizedString(), message: infoMessage!, okAction: {
                                NotificationCenter.default.post(name:Notification.Name("resetValue"), object: nil)
                                
                            })
                        }
                        if json["errMsg"].exists() {
                            
                            errMessageString = json["errMsg"].stringValue
                            response = .success(nil, nil)
                            print("Message aaa: \(String(describing: errMessageString))")
                            
                            KVLoading.hide(animated: true)
                            
                            let vc = self.getTopVC()
                            vc?.showAlertControllerFromExtension(title: "Thông báo".localizedString(), message: errMessageString!, okAction: {
                                NotificationCenter.default.post(name:Notification.Name("resetValue"), object: nil)
                                
                            })
                        }else if json["errorMsg"].exists() {
                            
                            errorMessageString = json["errorMsg"].stringValue
                            response = .success(nil, nil)
                            print("Message bbb: \(String(describing: errorMessageString))")
                            
                            KVLoading.hide(animated: true)
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
