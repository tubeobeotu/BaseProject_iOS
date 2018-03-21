import Foundation

class BaseViewModel  {
    
    internal var screenCoordinator: ScreenCoordinator!
    internal let bag = DisposeBag()
    
    init(_ screenCoordinator: ScreenCoordinator) {
        self.screenCoordinator = screenCoordinator
        initValue()
    }
    init() {
        initValue()
    }
    internal func initValue() {
        // You can override here for any view model don't need others properties init. Ex: SplashViewModel
    }
    
    deinit {
        debugPrint("\(self.viewModelName) Already Deallocate")
    }
    
    func backAction() -> CocoaAction {
        return CocoaAction{
            
            return Observable.just(self.popBack())
        }
    }
    
    func popToRootAction() -> CocoaAction {
        return CocoaAction{
            
            return Observable.just(self.popToRoot())
        }
    }
    
    func popToRoot()
    {
        let _ = self.screenCoordinator.popToRoot(animated: true)
    }
    
    func popBack()
    {
        if (ScreenCoordinator.currentViewController?.presentingViewController) != nil
        {
            self.screenCoordinator.dismiss(animated: true)
        }else{
            self.screenCoordinator.pop(animated: true)
        }
    }
}

extension BaseViewModel {
    
    internal var viewModelName: String {
        return String(describing: self)
    }
    
}

