import Foundation

protocol Wireframe {
  func promptFor<ActionTitle: CustomStringConvertible>(_ title: String?, message: String, cancelAction: ActionTitle, actions: [ActionTitle]) -> Observable<ActionTitle>
}

class WireFrameDefault: Wireframe {
  
  static let shared = WireFrameDefault()
  
  fileprivate static func topViewController() -> UIViewController? {
    if var topController = UIApplication.shared.keyWindow?.rootViewController {
      while let presentedViewController = topController.presentedViewController {
        topController = presentedViewController
      }
      return topController
    }
    
    return nil
  }
  
  static func presentAlert(_ title: String? = nil, message: String) {
    let alertView = UIAlertController(title: "Warning".localized(), message: message, preferredStyle: .alert)
    alertView.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
    })
    topViewController()?.present(alertView, animated: true, completion: nil)
  }
  
  func promptFor<ActionTitle : CustomStringConvertible>(_ title: String? = nil, message: String, cancelAction: ActionTitle, actions: [ActionTitle]) -> Observable<ActionTitle> {
    
    return Observable.create { observer in
      let alertView = UIAlertController(title: title ?? "", message: message, preferredStyle: .alert)    
      
      for action in actions {
        alertView.addAction(UIAlertAction(title: action.description, style: .default) { _ in
          observer.on(.next(action))
          observer.onCompleted()
        })
      }
      
      alertView.addAction(UIAlertAction(title: cancelAction.description, style: .cancel) { _ in
        observer.on(.next(cancelAction))
        observer.onCompleted()
      })
      
      alertView.view.tintColor = AppColor.secondaryColor.value
      
      WireFrameDefault.topViewController()?.present(alertView, animated: true, completion: nil)
      
      return Disposables.create {
        alertView.dismiss(animated:false, completion: nil)
      }
    }
  }
  
  func promptForNetworkingError<ActionTitle : CustomStringConvertible>(_ title: String? = nil, code: String, cancelAction: ActionTitle, actions: [ActionTitle]) -> Observable<ActionTitle> {
    
    let message = ErrorCodeDefine.networkErrorCode(code)
    return WireFrameDefault.shared.promptFor(message: message, cancelAction: cancelAction, actions: actions)
  }
  
}

