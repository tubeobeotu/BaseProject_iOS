import Foundation

class ScreenCoordinator: ScreenCoordinatorType {
  
  fileprivate var window: UIWindow
  static var currentViewController: UIViewController?
  static var sharedInstance = ScreenCoordinator(nil)
  static var currentViewControllerBeforeModal: UIViewController?
  required init(_ window: UIWindow?) {
    if let currentWindow = window
    {
      self.window = currentWindow
      ScreenCoordinator.currentViewController = currentWindow.rootViewController
    }else{
      self.window = UIApplication.shared.windows.first!
    }
  }
  
  static func presentingViewController(_ viewController: UIViewController) -> UIViewController {
    if let navigationController = viewController as? UINavigationController {
      return navigationController.viewControllers.first!
    } else {
      return viewController
    }
  }
  
  @discardableResult
  func transition(to viewController: UIViewController, type: ScreenTransitionType) -> Completable {
    let subject = PublishSubject<()>()
    switch type {
    case .root:
      
      ScreenCoordinator.currentViewController = ScreenCoordinator.presentingViewController(viewController)
      window.set(rootViewController: viewController)
      window.makeKeyAndVisible()
      subject.onCompleted()
      
    case .push:
      if let slideViewController = ScreenCoordinator.currentViewController as? SlideMenuController, let homeViewController = slideViewController.mainViewController as? UINavigationController {
        
        _ = homeViewController.rx.delegate.sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:))).map { _ in }.bind(to: subject)
        
        homeViewController.pushViewController(viewController, animated: true)
        ScreenCoordinator.currentViewController = ScreenCoordinator.presentingViewController(viewController)
        
      } else {
        if let navigationController = ScreenCoordinator.currentViewController?.navigationController
        {
          _ = navigationController.rx.delegate.sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:))).map { _ in }.bind(to: subject)
          
          navigationController.pushViewController(viewController, animated: true)
          ScreenCoordinator.currentViewController = ScreenCoordinator.presentingViewController(viewController)
        }
        else {
          //                    fatalError("Can't push a view controller without a current navigation controller")
          debugPrint("Can't push a view controller without a current navigation controller")
        }
        
        
      }
      
    case .modal:
      ScreenCoordinator.currentViewControllerBeforeModal = ScreenCoordinator.currentViewController
      ScreenCoordinator.currentViewController?.present(viewController, animated: true) {
        ScreenCoordinator.currentViewController = ScreenCoordinator.presentingViewController(viewController)
        subject.onCompleted()
      }
      
    case .childViewWithTransparent(let animate):
      let transparentView = transparentForParentViewController()
      ScreenCoordinator.currentViewController?.view.addSubview(transparentView)
      ScreenCoordinator.currentViewController?.view.addSubview(viewController.view)
      ScreenCoordinator.currentViewController?.addChildViewController(viewController)
      viewController.didMove(toParentViewController: ScreenCoordinator.currentViewController)
      
      if animate {
        transparentView.alpha = 0.0
        viewController.view.alpha = 0.0
        UIView.animate(withDuration: 0.3, animations: {
          transparentView.alpha = 1.0
          viewController.view.alpha = 1.0
        })
      }
      
      subject.onCompleted()
      
    case .childView(let animate, let childViewFrame):
      viewController.view.frame = childViewFrame
      ScreenCoordinator.currentViewController?.view.addSubview(viewController.view)
      ScreenCoordinator.currentViewController?.addChildViewController(viewController)
      viewController.didMove(toParentViewController: ScreenCoordinator.currentViewController)
      
      if animate {
        viewController.view.alpha = 0.0
        UIView.animate(withDuration: 0.3, animations: {
          viewController.view.alpha = 1.0
        })
      }
      
      subject.onCompleted()
    }
    
    
    return subject.asObserver().take(1).ignoreElements()
  }
  func transition(to screen: Screen, type: ScreenTransitionType) -> Completable {
    let viewController = screen.viewController()
    return self.transition(to: viewController, type: type)
  }
  
  
  @discardableResult
  func dismiss(animated: Bool) -> Completable {
    let subject = PublishSubject<()>()
    
    if let presenter = ScreenCoordinator.currentViewControllerBeforeModal {
      ScreenCoordinator.currentViewController?.dismiss(animated: animated) {
        ScreenCoordinator.currentViewController = presenter
        subject.onCompleted()
      }
      
    } else {
      fatalError("Not a modal : can't dismiss back from \(ScreenCoordinator.currentViewController?.nibName ?? "")")
    }
    
    return subject.asObserver().take(1).ignoreElements()
  }
  
  @discardableResult
  func pop(animated: Bool) -> Completable {
    
    let subject = PublishSubject<()>()
    
    if let navigationController = ScreenCoordinator.currentViewController?.navigationController {
      
      guard navigationController.popViewController(animated: true) != nil else { fatalError("Can't navigation back from \(ScreenCoordinator.currentViewController?.nibName ?? "")") }
      
      _ = navigationController.rx.delegate.sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:))).map { _ in }.bind(to: subject)
      
      ScreenCoordinator.currentViewController = ScreenCoordinator.presentingViewController(navigationController.viewControllers.last!)
      
    } else {
      fatalError("Not a modal, no navigation controller: can't navigate back from \(ScreenCoordinator.currentViewController?.nibName ?? "")")
    }
    
    return subject.asObserver().take(1).ignoreElements()
  }
  
  func popToRoot(animated: Bool) -> Completable {
    
    let subject = PublishSubject<()>()
    if let navigationController = ScreenCoordinator.currentViewController?.navigationController {
      
      guard navigationController.popToRootViewController(animated: animated) != nil else { fatalError("Can't navigation back from \(ScreenCoordinator.currentViewController?.nibName ?? "")") }
      
      _ = navigationController.rx.delegate.sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:))).map { _ in }.bind(to: subject)
      
      ScreenCoordinator.currentViewController = ScreenCoordinator.presentingViewController(navigationController.viewControllers.last!)
      
    } else {
      fatalError("Not a modal, no navigation controller: can't navigate back from \(ScreenCoordinator.currentViewController?.nibName ?? "")")
    }
    
    return subject.asObserver().take(1).ignoreElements()
  }
  
  @discardableResult
  func removeChildViewWithTransparent(animated: Bool) -> Completable {
    guard let currentChildViewController = ScreenCoordinator.currentViewController?.childViewControllers.last else { fatalError("\(ScreenCoordinator.currentViewController?.nibName ?? "") don't have any child view") }
    
    var transparentView: UIView!
    
    _ = ScreenCoordinator.currentViewController?.view.subviews.filter { $0.tag == 10001 }.map { transparentView = $0 }
    
    if animated {
      UIView.animate(withDuration: 0.3, animations: {
        transparentView.alpha = 0.0
        currentChildViewController.view.alpha = 0.0
      }, completion: { _ in
        transparentView.removeFromSuperview()
        currentChildViewController.willMove(toParentViewController: nil)
        currentChildViewController.view.removeFromSuperview()
        currentChildViewController.removeFromParentViewController()
      })
    } else {
      transparentView.removeFromSuperview()
      currentChildViewController.view.removeFromSuperview()
    }
    
    return .empty()
  }
  
  
  @discardableResult
  func removeChildView(animated: Bool) -> Completable {
    
    guard let currentChildViewController = ScreenCoordinator.currentViewController?.childViewControllers.last else { fatalError("\(ScreenCoordinator.currentViewController?.nibName ?? "") don't have any child view") }
    
    if animated {
      UIView.animate(withDuration: 0.3, animations: {
        currentChildViewController.view.alpha = 0.0
      }, completion: { _ in
        currentChildViewController.willMove(toParentViewController: nil)
        currentChildViewController.view.removeFromSuperview()
        currentChildViewController.removeFromParentViewController()
      })
    } else {
      currentChildViewController.view.removeFromSuperview()
    }
    
    return .empty()
  }
  
  fileprivate func transparentForParentViewController() -> UIView {
    let transparentView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: Ultil.screenWidth, height: Ultil.screenHeight))
    transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
    transparentView.tag = 10001
    let dismissGesture = UITapGestureRecognizer(target:  self, action: #selector(removeChildViewGesture))
    transparentView.addGestureRecognizer(dismissGesture)
    
    return transparentView
  }
  
  @objc fileprivate func removeChildViewGesture() {
    guard let currentChildViewController = ScreenCoordinator.currentViewController?.childViewControllers.last else { fatalError("\(ScreenCoordinator.currentViewController?.nibName ?? "") don't have any child view") }
    
    currentChildViewController.willMove(toParentViewController: nil)
    
    var transparentView: UIView!
    
    _ = ScreenCoordinator.currentViewController?.view.subviews.filter { $0.tag == 10001 }.map { transparentView = $0 }
    
    UIView.animate(withDuration: 0.3, animations: {
      transparentView.alpha = 0.0
    }, completion: { _ in
      transparentView.removeFromSuperview()
      currentChildViewController.view.removeFromSuperview()
      currentChildViewController.removeFromParentViewController()
    })
  }
  
}
