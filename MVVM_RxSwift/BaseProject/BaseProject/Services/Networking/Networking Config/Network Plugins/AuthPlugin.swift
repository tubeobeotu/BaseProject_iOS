import Foundation
import Result

class AuthPlugin: PluginType {
  
  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    var request = request
    if let accessToken = Customer.signedInCustomer?.token?.accessToken, let requestURL = request.url?.absoluteString, requestURL != "\(BASE_URL_ADDRESS)\(AuthEndPoint.refreshAccessToken)",
      requestURL != "\(BASE_URL_ADDRESS)\(FirebaseFCMEndPoint.unRegisterFCMToken)" {
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    }
    return request
  }

    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        return result
    }
  
}

