import Foundation

class ABError: Error, Mappable {
  var code = ""
  var message = ""
  
  init(_ code: String?, message: String) {
    self.code = code ?? ""
    self.message = message
  }
  
  required init?(map: Map) {
    
    if let errorCode = map.JSON["code"] {
        self.code = "\(errorCode)"
    } else {
      return nil
    }
    
    if let errorMessage = map.JSON["error"] {
        self.message = "\(errorMessage)"
    } else {
      if let errorMessage = map.JSON["message"] {
        self.message = "\(errorMessage)"
      } else {
        return nil
      }
    }
    
  }
  
  func mapping(map: Map) {}
  
}

extension ABError {
  
  
  
}
