import SwiftyJSON

class User: BaseDataModel {
    
    var userId: String?
    var token: String?
    var userToken: String?
    var username: String?
    var fullname : String?
    
    var password: String?
    var email: String?
    var userType: UserType?
    var phone: String?
    var locationCode: String?
    var departmentId : String?
    var departmentName: String?
    var listMenu: [Menu]?
    var resultMessage: String?
    var listRoles: [String]?
    var departmentCode: String?
    
    convenience init(localUser: LocalUser) {
        self.init()
        self.userId = localUser.userId
        self.token = localUser.token
        self.userToken = localUser.userToken
        self.username = localUser.username
        self.fullname = localUser.fullname
        self.password = localUser.password
        self.email = localUser.email
        self.userType = localUser.userType
        self.phone = localUser.phone
        self.locationCode = localUser.locationCode
        self.departmentId = localUser.departmentId
        self.departmentName = localUser.departmentName
        self.listMenu = localUser.listMenu
        self.departmentCode = localUser.departmentCode
    }
    
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
            userType = UserType.rawUserType(roleId: roleId, levelUser: levelUser)
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

class LocalUser: NSObject, NSCoding {
    
    var userId: String?
    var token: String?
    var userToken: String?
    var username: String?
    var fullname: String?
    var password: String?
    var email: String?
    var userType: UserType?
    var phone: String?
    var locationCode: String?
    var departmentId : String?
    var departmentName: String?
    var listMenu: [Menu]?
    var listRoles: [String]?
    var departmentCode: String?
    static let shared = LocalUser()
    var currentUser: LocalUser? {
        set {
            if let currentUser = newValue {
                let encodeUser = NSKeyedArchiver.archivedData(withRootObject: currentUser)
                UserDefaults.standard.set(encodeUser, forKey: "user")
            }
        }
        
        get {
            if UserDefaults.standard.object(forKey: "user") != nil {
                let data = UserDefaults.standard.object(forKey: "user")
                if let data = data as? Data {
                    if let localUser = NSKeyedUnarchiver.unarchiveObject(with: data) as? LocalUser {
                        return localUser
                    }
                }
            }
            
            return nil
        }
    }
    
    func saveUser(_ user: LocalUser) {
        currentUser = user
    }
    
    func removeCurrentUser() {
        UserDefaults.standard.removeObject(forKey: "user")
    }
    
    func requiredUser() -> Bool {
        if LocalUser.shared.currentUser == nil {
            return true
        }
        
        return false
    }
    
    override init() {}
    
    convenience init(user: User) {
        self.init()
        self.userId = user.userId
        self.token = user.token
        self.userToken = user.userToken
        self.username = user.username
        self.fullname = user.fullname
        self.password = user.password
        self.email = user.email
        self.userType = user.userType
        self.phone = user.phone
        self.locationCode = user.locationCode
        self.departmentId = user.departmentId
        self.departmentName = user.departmentName
        self.listMenu = user.listMenu
        self.listRoles = user.listRoles
        self.departmentCode = user.departmentCode
    }
    
    func encode(with aCoder: NSCoder) {
        if let userId = self.userId { aCoder.encode(userId, forKey: "userId") }
        if let token = self.token { aCoder.encode(token, forKey: "token") }
        if let userToken = self.userToken { aCoder.encode(userToken, forKey: "userToken") }
        if let username = self.username { aCoder.encode(username, forKey: "username") }
        if let fullname = self.fullname { aCoder.encode(fullname, forKey: "fullname") }
        if let password = self.password { aCoder.encode(password, forKey: "password") }
        if let email = self.email { aCoder.encode(email, forKey: "email") }
        if let userType = self.userType { aCoder.encode(userType.toString(), forKey: "userType") }
        if let phone = self.phone { aCoder.encode(phone, forKey: "phone") }
        if let locationCode = self.locationCode { aCoder.encode(locationCode, forKey: "locationCode") }
        if let departmentId = self.departmentId { aCoder.encode(departmentId, forKey: "departmentId") }
        if let departmentName = self.departmentName { aCoder.encode(departmentName, forKey: "departmentName") }
        if let listMenu = self.listMenu { aCoder.encode(listMenu, forKey: "listMenu") }
        if let listRoles = self.listRoles { aCoder.encode(listRoles, forKey: "listRoles") }
        if let departmentCode = self.departmentCode { aCoder.encode(departmentCode, forKey: "departmentCode") }
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.userId = aDecoder.decodeObject(forKey: "userId") as? String
        self.token = aDecoder.decodeObject(forKey: "token") as? String
        self.userToken = aDecoder.decodeObject(forKey: "userToken") as? String
        self.username = aDecoder.decodeObject(forKey: "username") as? String
        self.fullname = aDecoder.decodeObject(forKey: "fullname") as? String
        self.password = aDecoder.decodeObject(forKey: "password") as? String
        self.email = aDecoder.decodeObject(forKey: "email") as? String
        self.userType = UserType.rawUserTypeFromString((aDecoder.decodeObject(forKey: "userType") as? String))
        self.phone = aDecoder.decodeObject(forKey: "phone") as? String
        self.locationCode = aDecoder.decodeObject(forKey: "locationCode") as? String
        self.departmentId = aDecoder.decodeObject(forKey: "departmentId") as? String
        self.departmentName = aDecoder.decodeObject(forKey: "departmentName") as? String
        self.listMenu = aDecoder.decodeObject(forKey: "listMenu") as? [Menu]
        self.listRoles = aDecoder.decodeObject(forKey: "listRoles") as? [String]
        self.departmentCode = aDecoder.decodeObject(forKey: "departmentCode") as? String
    }
}

