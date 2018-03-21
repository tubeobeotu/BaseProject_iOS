import Foundation
import Result

class NetworkErrorTransformPlugin: PluginType {
    
    func process(_ result: Result<Moya.Response, MoyaError>, target: TargetType) -> Result<Moya.Response, MoyaError> {
        
        switch result {
        case .success(let response):
            if (200...299).contains(response.statusCode) {
                
                if let serverError = try? response.mapObject(ABError.self) {
                    return Result.failure(MoyaError.underlying(serverError, response))
                }
                
                return result
            }
            
            do {
                let serverError = try response.mapObject(ABError.self)
              
              if serverError.code == "20001" {
                AppInitManager.isStoreDeactive = true
                _ = ScreenCoordinator.sharedInstance.transition(to: .deactiveStore(DeactiveStoreViewModel()), type: .root)
                
                return Result.failure(MoyaError.statusCode(response))
              } else {
                return Result.failure(MoyaError.underlying(serverError, response))
              }
              
            } catch {
                return Result.failure(MoyaError.underlying(error, response))
            }
            
        case .failure( _):
            return result
        }
        
        
    }
}
