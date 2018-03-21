
import Foundation
import Reachability


let appDelegate = UIApplication.shared.delegate as! AppDelegate

class AppInitManager {
    
    fileprivate static var reachability: Reachability?
    fileprivate static let bag = DisposeBag()
  
    static var isStoreDeactive = false
  
    public static func initApp() {
        setupAppFlow()
        setupSettingsInitApp()
        setupReachability()
    }
    
    fileprivate static func setupReachability() {
        AppInitManager.reachability = Reachability()
        try? AppInitManager.reachability?.startNotifier()
        
        reachability?
            .rx
            .isReachable
            .filter { !$0 }
            .flatMapLatest { _ in
                return WireFrameDefault.shared.promptFor(message: AlertMessage.noNetworking , cancelAction: AlertAction.ok, actions: [])
            }
            .subscribe()
            .disposed(by: bag)
    }
    
    
    fileprivate static func setupSettingsInitApp() {
        Fabric.with([Crashlytics.self])
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        IQKeyboardManager.sharedManager().disabledTouchResignedClasses.append((ABBaseMapViewVC.self))
        UITabBar.appearance().tintColor = AppColor.secondaryColor.value
    }
    
    fileprivate static func setupAppFlow() {
        LogoAndSplashHelper.configSplashAndLogo()
        appDelegate.window = UIWindow(frame: Ultil.deviceScreenSize)
        let screenCoordinator = ScreenCoordinator(appDelegate.window!)
        let splashViewModel = SplashViewModel(screenCoordinator)
        _ = screenCoordinator.transition(to: .splash(splashViewModel), type: .root)
    }
    
    
}


