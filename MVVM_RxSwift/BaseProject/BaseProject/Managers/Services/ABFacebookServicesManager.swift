import Foundation
import FBSDKCoreKit

final class ABFacebookServicesManager {
  
  fileprivate static let facebookLoginManager = FBSDKLoginManager()
  
  fileprivate static let facebookProfilePermission = "public_profile"
  fileprivate static let facebookEmailPermission   = "email"
  
  static func configureForSwitchingToFB(application: UIApplication, options: [AnyHashable: Any]?) {
    FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: options)
  }
  
  static func openFBUpToiOS9(application: UIApplication, options: [UIApplicationOpenURLOptionsKey: Any], url: URL) -> Bool {
    return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, options: options)
  }
  
  static func openFBBelowiOS9(application: UIApplication, url: URL, source: String, annotation: Any) -> Bool {
    return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: source, annotation: annotation)
  }
  
  static func login() -> Observable<String?> {
    guard let topViewController = UIViewController.getTopVC() else { return .empty() }
    facebookLoginManager.logOut()
    return Observable.deferred {
      
      return Observable<String?>.create { observer in
        facebookLoginManager.logIn(withReadPermissions: [facebookEmailPermission, facebookProfilePermission], from: topViewController) { (result, error) in
          
          if let _ = error {
            observer.onNext(nil)
          } else if let _result = result, !_result.isCancelled {
            
            guard let token = _result.token.tokenString else {
              observer.onNext(nil)
              return
            }
            observer.onNext(token)
          }
          
        }
        
        return Disposables.create()
      }
    }
    
  }
  
  static func userProfile() -> Observable<SocialProtocol> {
    
    return Observable.deferred {
      return Observable<SocialProtocol>.create { observer in
        FBSDKGraphRequest(graphPath: FacebookInformation.pathRequest, parameters: FacebookInformation.parameterRequest).start { (_, result, error) in
          if let _error = error {
            observer.onError(_error)
          } else {
            guard let result = result as? [String: Any],
              let name = result[FacebookInformation.nameKey] as? String,
              let email = result[FacebookInformation.emailKey] as? String  else { return }
            
            let facebookInformation = FacebookInformation(name: name, email: email)
            observer.onNext(facebookInformation)
          }
        }
        return Disposables.create()
      }
    }
    
  }
  
  
}

