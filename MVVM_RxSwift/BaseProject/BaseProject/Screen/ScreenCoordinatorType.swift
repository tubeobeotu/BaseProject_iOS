
import Foundation

protocol ScreenCoordinatorType {

  @discardableResult
  func transition(to scene: Screen, type: ScreenTransitionType) -> Completable
  
  @discardableResult
  func pop(animated: Bool) -> Completable
    
  @discardableResult
  func removeChildViewWithTransparent(animated: Bool) -> Completable
  
  @discardableResult
  func removeChildView(animated: Bool) -> Completable
  
  @discardableResult
  func dismiss(animated: Bool) -> Completable
}

extension ScreenCoordinatorType {
  @discardableResult
  func pop() -> Completable {
    return pop(animated: true)
  }
  
  @discardableResult
  func dismiss() -> Completable {
    return dismiss(animated: true)
  }
}

enum ScreenTransitionType {
  case root       // make view controller the root view controller
  case push       // push view controller to navigation stack
  case modal      // present view controller modally
  case childViewWithTransparent(animate: Bool)  // present childview controller
  case childView(animate: Bool, childViewFrame: CGRect)
}
