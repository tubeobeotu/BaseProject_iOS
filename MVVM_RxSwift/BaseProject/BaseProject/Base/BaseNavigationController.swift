import UIKit

class BaseNavigationController: UINavigationController {
  
  var showNavigationBar: Bool = true {
    didSet{
      showNavigationBar ? showNavBar() : hideNavBar()
    }
  }
  var transparentBar: Bool = false
  {
    didSet{
      if(transparentBar == true)
      {
        self.transparentNavBar()
      }
    }
  }
  
  var lightStatusBar: Bool = true {
    didSet{
      if lightStatusBar {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
      } else {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    setupUI()
  }
  
  fileprivate func setupNavigationBar() {
    delegate = self
    interactivePopGestureRecognizer?.delegate = self
  }
  
  fileprivate func setupUI () {
    navigationBar.barTintColor = AppColor.primaryColor.value
    navigationBar.tintColor = AppColor.navigationTextColor.value
    navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: AppColor.navigationTextColor.value,
                                         NSAttributedStringKey.font: AppFont.bold(fontSize: 15).font]
  }
  
}


extension BaseNavigationController {
  
  fileprivate func showNavBar() {
  
    navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: .default), for: .default)
    navigationBar.shadowImage = UINavigationBar.appearance().shadowImage
    navigationBar.isTranslucent = UINavigationBar.appearance().isTranslucent
    setNavigationBarHidden(false, animated: true)
  }
  
  fileprivate func hideNavBar() {
    self.transparentNavBar()
    setNavigationBarHidden(true, animated: false)
  }
  
  fileprivate func transparentNavBar() {
    navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationBar.shadowImage = UIImage()
    navigationBar.isTranslucent = true
    navigationBar.barTintColor = UIColor.white
  }
  
}

extension BaseNavigationController: UIGestureRecognizerDelegate, UINavigationControllerDelegate {
  
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
  func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    
    guard let popedViewController = navigationController.transitionCoordinator?.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
    
    
    if !navigationController.viewControllers.contains(popedViewController) {
      ScreenCoordinator.currentViewController = ScreenCoordinator.presentingViewController(navigationController.viewControllers.last!)
    }
    
  }
}
