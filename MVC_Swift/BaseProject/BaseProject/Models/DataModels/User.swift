import SwiftyJSON

class User: BaseDataModel {
    
    var userId: String?
    var token: String?
    var userToken: String?
    var username: String?
    var fullname : String?
    
    var password: String?
    var email: String?
    var phone: String?
    var locationCode: String?
    var departmentId : String?
    var departmentName: String?
    var listMenu: [Menu]?
    var resultMessage: String?
    var listRoles: [String]?
    var departmentCode: String?

    
    override func mapping(json: JSON) {
        super.mapping(json: json)
        if json["success"]["userId"].exists() {
            objectId = json["success"]["userId"].stringValue
            userId = json["success"]["userId"].stringValue
        }
        
        if json["token"].exists() {
            token = json["token"].stringValue
        }
        
        if json["userToken"].exists() {
            userToken = json["userToken"].stringValue
        }
        
        if json["success"]["username"].exists() {
            username = json["success"]["username"].stringValue
        }
        
        if json["success"]["username"].exists() {
            username = json["success"]["username"].stringValue
        }
        if json["success"]["fullname"].exists() {
            fullname = json["success"]["fullname"].stringValue
        }
        if json["success"]["email"].exists() {
            email = json["success"]["email"].stringValue
        }
        
        if json["success"]["roleId"].exists() && json["success"]["levelUser"].exists() {
            let roleId = json["success"]["roleId"].intValue
            let levelUser = json["success"]["levelUser"].intValue

        }
        
        if json["success"]["phone"].exists() {
            phone = json["success"]["phone"].stringValue
        }
        
        if json["success"]["locationCode"].exists() {
            locationCode = json["success"]["locationCode"].stringValue
        }
        
        if json["success"]["departmentId"].exists() {
            departmentId = json["success"]["departmentId"].stringValue
        }
        
        if json["success"]["departmentName"].exists() {
            departmentName = json["success"]["departmentName"].stringValue
        }
        
        if json["success"]["departmentCode"].exists() {
            departmentCode = json["success"]["departmentCode"].stringValue
        }
        
        if json["lstMenu"].exists() {
            listMenu = [Menu](byJSON: json["lstMenu"])
        }
        
        if json["result"].exists() {
            resultMessage = json["result"].stringValue
        }
    }
}

