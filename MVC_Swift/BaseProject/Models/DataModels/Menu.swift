import SwiftyJSON

class Menu: BaseDataModel, NSCoding {
    
    var level: Int?
    var suggestId: String?
    var ord: Int?
    var parentId: Int?
    var status: Int?
    var objectType: Int?
    var objectName: String?
    var objectUrl: MenuType?
    var childObjects: [Menu]?
    
    override func mapping(json: JSON) {
        super.mapping(json: json)
        if json["objectId"].exists() {
            objectId = json["objectId"].intValue.toString()
        }
        
        if json["ord"].exists() {
            ord = json["ord"].intValue
        }
        
        if json["parentId"].exists() {
            parentId = json["parentId"].intValue
        }
        
        if json["status"].exists() {
            status = json["status"].intValue
        }
        
        if json["objectType"].exists() {
            status = json["objectType"].intValue
        }
        
        if json["objectUrl"].exists() {
            objectUrl = MenuType(rawValue: json["objectUrl"].intValue)
            if(json["objectUrl"].stringValue == "#")
            {
                objectUrl = nil
            }else if(json["objectUrl"].intValue > 0 && objectUrl == nil)
            {
                objectUrl = .UnKown
            }
            if json["objectUrl"].intValue == 1000 {
                objectName = VTLocalizedString.localized(key: "objectNameWO")
            }else if json["objectUrl"].intValue == 2000 {
                objectName = VTLocalizedString.localized(key: "objectNameActivelyMonitoring")
            }else {
                if json["objectName"].exists() {
                    objectName = json["objectName"].stringValue
                }
            }
            
        }
        
        if json["childObjects"].exists() {
            childObjects = [Menu](byJSON: json["childObjects"])
            if let children = childObjects {
                for child in children {
                    child.level = self.level ?? 0 + 1
                }
            }
        }
    }
    
    func encode(with aCoder: NSCoder) {
        if let objectUrl = self.objectUrl?.rawValue { aCoder.encode(objectUrl, forKey: "objectUrl") }
        if let level = self.level { aCoder.encode(level, forKey: "level") }
        if let suggestId = self.suggestId { aCoder.encode(suggestId, forKey: "suggestId") }
        if let ord = self.ord { aCoder.encode(ord, forKey: "ord") }
        if let parentId = self.parentId { aCoder.encode(parentId, forKey: "parentId") }
        if let status = self.status { aCoder.encode(status, forKey: "status") }
        if let objectType = self.objectType { aCoder.encode(objectType, forKey: "objectType") }
        if let objectName = self.objectName { aCoder.encode(objectName, forKey: "objectName") }
        if let childObjects = self.childObjects { aCoder.encode(childObjects, forKey: "childObjects") }
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.objectUrl = MenuType(rawValue: aDecoder.decodeInteger(forKey: "objectUrl"))
        self.level = aDecoder.decodeInteger(forKey: "level")
        self.suggestId = aDecoder.decodeObject(forKey: "suggestId") as? String
        self.ord = aDecoder.decodeInteger(forKey: "ord")
        self.parentId = aDecoder.decodeInteger(forKey: "parentId")
        self.status = aDecoder.decodeInteger(forKey: "status")
        self.objectType = aDecoder.decodeInteger(forKey: "objectType")
        self.objectName = aDecoder.decodeObject(forKey: "objectName") as? String
        self.childObjects = aDecoder.decodeObject(forKey: "childObjects") as? [Menu]
    }
}
