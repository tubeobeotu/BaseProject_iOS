
import Foundation

//AIzaSyARo1rcTEonHXmQcv7hUJsMT8dBeef8fYo - Google place key backup
//AIzaSyBGm-Wg-v1oW1ExDO5IgH5BtwdNIoKk0Nw - Google place key
let URLTERM = "https://appgen-dev.heykorean.com/terms"
  let BASE_URL_ADDRESS = "https://appgen-dev.heykorean.com/api/"
  var storeId = "3"
  var storeType = 2
  let brancheId = "all"
  let stripeKey = "pk_test_0eko8hqk25iXIiYNKJIpZ2xL"
  let googleServiceKey = "AIzaSyDPazH_ecwiO7PXfUvQKWTmgWqCsSzbtcQ"
  let googlePlaceKey = "AIzaSyBGm-Wg-v1oW1ExDO5IgH5BtwdNIoKk0Nw"
  let googleClientID = "991612653343-dcthq12qja8t40frt0l5c3cpv3hae98j.apps.googleusercontent.com"





let provider = MoyaProvider<MultiTarget>(manager: ManagerDefaulNetworkingConfigure.sharedManager, plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter),
                                                                                                            AuthPlugin(),
                                                                                                            NetworkErrorTransformPlugin()])

class ManagerDefaulNetworkingConfigure: Manager {
  
  static let sharedManager: ManagerDefaulNetworkingConfigure = {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 60
    configuration.allowsCellularAccess = true
    let manager = ManagerDefaulNetworkingConfigure(configuration: configuration)
    return manager
  }()
  
}

extension TargetType {
  
  var baseURL: URL {
    return URL(string: BASE_URL_ADDRESS)!
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var headers: [String: String]? {
    return nil
  }
  
}



public func JSONResponseDataFormatter(_ data: Data) -> Data {
  do {
    let dataAsJSON = try JSONSerialization.jsonObject(with: data)
    let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
    return prettyData
  } catch {
    return data
  }
}



