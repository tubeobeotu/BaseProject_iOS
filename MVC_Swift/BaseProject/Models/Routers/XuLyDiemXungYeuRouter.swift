import Alamofire
import SwiftyJSON

enum XuLyDiemXungYeuEnpoint {
    case addCriticalPoint(item : WorkItemModel, supplies : String, resultType : String, objectType : Int)
    case updateCriticalPoint(object: CritialPointModel, woCode : String)
    case getCritialPoint(woCode : String)
}

class XuLyDiemXungYeuRouter: BaseRouter {
    
    var endpoint: XuLyDiemXungYeuEnpoint
    
    init(endpoint: XuLyDiemXungYeuEnpoint) {
        self.endpoint = endpoint
    }
    
    override var path: String {
        
        switch endpoint {
            
        case .addCriticalPoint(_,_,_,_):
            return "rest/ttbdController/addCriticalPoint"
            
        case .updateCriticalPoint(_,_):
            return "rest/ttbdController/processCriticalPoint"
            
        case .getCritialPoint(_):
            return "rest/gnocWOController/getCriticalPoint"
        }
    }
    
    override var method: HTTPMethod {
        return .post
    }
    
    override var parameters: [String: Any]? {
        var params = [String: Any]()
        let token = LocalUser.shared.currentUser?.token ?? "token"
        let userId = LocalUser.shared.currentUser?.userId ?? "userId"
        
        switch endpoint {
            
        case .updateCriticalPoint(let critialPoint,_):
            params["token"] = token
            params["userAssignId"] = userId
            params["criticalPoint"] = ["criticalPoint" : critialPoint.toDictionary().toString()].toString()
            break
            
        case .addCriticalPoint(let item, let supplies, let resultType, let objectType):
        
            params["token"] = token
            params["userAssignId"] = userId
            params["supplies"] = supplies
            params["resultType"] = resultType
            params["workId"] = item.workId
            params["objectType"] = objectType.toString()
            params["criticalPoint"] = item.toDictionaryLevel3().toString()
            break
            
        case .getCritialPoint(let woCode):
            params["token"] = token
            params["userAssignId"] = userId
            params["woCode"] = woCode
            break
        }
        return params
    }
    
    override var multipartBody: [MultipartFormData]? {
        
        let form = MultipartFormData()
        
        switch endpoint {
            
        case .updateCriticalPoint(let critialPoint,_):
            
            for (index, file) in critialPoint.images.enumerated() {
                
                let name = "image" + index.toString()
                
                form.append(UIImageJPEGRepresentation(file.image, 1.0)!, withName: name, fileName: (file.name as NSString).lastPathComponent.lowercased(), mimeType: "image/jpeg")
            }
            
            return [form]
            
        case .addCriticalPoint(let item,_,_,_):
            
            for (index, file) in item.imageList.enumerated() {
                
                let name = "image" + index.toString()
                
                form.append(UIImageJPEGRepresentation(file.image, 1.0)!, withName: name, fileName: (file.name as NSString).lastPathComponent.lowercased(), mimeType: "image/jpeg")
                
            }
            
            return [form]
            
        default:
            return nil
        }
    }
    
    override var uploadFiles : [UploadFile]? {
        var files = [UploadFile]()
        
        switch endpoint {
            
        case .updateCriticalPoint(let critialPoint,_):
            

            for (index, image) in critialPoint.images.enumerated() {
                
                var file = UploadFile()
                let imageIndex: Int = index + 1
                file.data = UIImageJPEGRepresentation(image.image, 1.0)!
                file.name = "image" + imageIndex.toString()
                file.fileName = (image.name as NSString).lastPathComponent.lowercased()
                file.mineType = "image/jpeg"
                files.append(file);
            }
            
            return files
            
        case .addCriticalPoint(let item,_,_,_):
            
            for (index, image) in item.imageList.enumerated() {
                if image.image != nil {
                    var file = UploadFile()
                    let imageIndex: Int = index + 1
                    file.data = UIImageJPEGRepresentation(image.image, 1.0)!
                    file.name = "image" + imageIndex.toString()
                    file.fileName = (image.name as NSString).lastPathComponent.lowercased()
                    file.mineType = "image/jpeg"
                    files.append(file)
                }
            }
            
            return files
            
        default:
            return nil
        }

    }
    
    override var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    override var headerFields: [String: String]? {
        guard let currentUser = LocalUser.shared.currentUser else {
            return nil
        }
        
        let userToken = currentUser.userToken ?? "userToken"
        let username = currentUser.username ?? "username"
        var headers = [String: String]()
        headers["token"] = userToken
        headers["username"] = username
        
        //Update
        let timeNow = Int64(Date().timeIntervalSince1970 * 1000)
        //            "_"+ Common.imeiId + "_" + time
        let requestClientId = String(timeNow)
        var userNameString = UserRouter.userName
        if (userNameString == nil){
            userNameString = ""
        }
        let stringRequestClientId = userNameString! + "_null_" + requestClientId
        if let countryCode = (Locale.current as NSLocale).object(forKey: .languageCode) as? String {
            print(countryCode)
            headers["locale"] = countryCode as String
        }
        headers["requestClientId"] = stringRequestClientId as String
        headers["Authen"] = "VSMART"
        
        return headers
    }
    
    override func response(json: JSON) -> Any? {
        
        switch endpoint {
            
        case .addCriticalPoint(_,_,_,_):
            return BaseDataModel(byJSON: json)
            
        case .updateCriticalPoint(_,_):
            return BaseDataModel(byJSON: json)
            
        case .getCritialPoint(_):
            if json["critial"].exists() {
                return CritialPointModel(byJSON: json["critial"])
            } else {
               return BaseDataModel(byJSON: json)
            }
        }
    }
    
    override func errorResponse(json: JSON) -> Any? {
        return BaseDataModel(byJSON: json)
    }
    
    override func otherResponse(json: JSON) -> Any? {
        return BaseDataModel(byJSON: json)
    }
}
