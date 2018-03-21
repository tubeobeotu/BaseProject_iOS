import Foundation

class ABGoogleServicesManager: NSObject {
    
  var userProfile = PublishSubject<GoogleInformation>()
  var currentUserProfile: GoogleInformation?
    
    static func openGGUpToiOS9(application: UIApplication, options: [UIApplicationOpenURLOptionsKey: Any], url: URL) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    static func openGGBelowiOS9(application: UIApplication, url: URL, source: String, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: source, annotation: annotation)
    }
    
    func login() {
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().clientID = googleClientID
        GIDSignIn.sharedInstance().signIn()        
    }
    
}

extension ABGoogleServicesManager: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
          
        } else {
            let googleSocial = GoogleInformation(name: user.profile.name, email: user.profile.email, token: user.authentication.idToken)
          currentUserProfile = googleSocial
          self.userProfile.onNext(googleSocial)
        }
        
    }
    
}

extension ABGoogleServicesManager: GIDSignInUIDelegate {
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        UIViewController.getTopVC()?.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        UIViewController.getTopVC()?.dismiss(animated: true, completion: nil)
    }
    
}
