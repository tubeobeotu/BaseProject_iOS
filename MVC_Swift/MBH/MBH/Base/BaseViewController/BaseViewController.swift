import UIKit
enum ContentState {
    case hasContent
    case loading
    case empty
    case error
    case done
}

class BaseViewController: UIViewController, IDependency{
    lazy var isLoadConfig = false
    private var enableHideKeyBoardWhenTouchInScreen: Bool = false
    var enableNotification = true
    var isLeftMenu = false
    var isEnableHideKeyBoardWhenTouchInScreen: Bool {
        get {
            return self.enableHideKeyBoardWhenTouchInScreen ? true : false
        }
        
        set {
            
            self.enableHideKeyBoardWhenTouchInScreen = newValue
            if self.enableHideKeyBoardWhenTouchInScreen {
                let touchOnScreen = UITapGestureRecognizer(target: self, action: #selector(self.touchOnScreen))
                touchOnScreen.delegate = self
                touchOnScreen.cancelsTouchesInView = false
                view.addGestureRecognizer(touchOnScreen)
            }
        }
    }
    
    var isEnabledLeftPanGesture: Bool = true
    
    lazy var masterView: UIView = {
        if let masterView = self.navigationController?.view {
            return masterView
        } else {
            return self.view
        }
    }()
    
    lazy var isLoading: Bool = false
    lazy var loading: LoadingView = {
        return LoadingView.loadFromNib()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        view.backgroundColor = Constant.color.backgroundVSmart
        registerForBackgroundNotifications()
        
        navigationController?.navigationBar.topItem?.title = ""
        
    }
    
    func reloadData() {
        
    }
    
    func configuration() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(!self.isLoadConfig)
        {
            configuration()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.touchOnScreen()
        if(self .isMovingFromParentViewController)
        {
            self.willPopBack()
        }else{
            self.willPush()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    deinit {
        destroyForBackgroundNotifications()
    }
    
    func willPopBack()
    {
        
    }
    func willPush()
    {
        
    }
    
    func handleError(error: IError){
        self.touchOnScreen()
        self.showAlertControllerFromExtension(title: error.getTitle() ?? "", message: error.getErrorDescription() ?? "", okAction: nil)
    }
    
    func setupDependency() {
        fatalError("[\(#function))] Must be overridden in subclass")
    }
    
}
extension BaseViewController
{
    func show(vc: UIViewController)
    {
        if let nav = self.navigationController
        {
            nav.pushViewController(vc, animated: true)
        }else{
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    func popBack()
    {
        self.willPopBack()
        if (self.navigationController?.presentingViewController) != nil
        {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    
}
extension BaseViewController {
    
    // MARK: - Actions
    @objc func touchOnScreen() {
        view.endEditing(true)
    }
    
    func continueAnimation() {
        loading.startRotate()
    }
}

extension BaseViewController {
    
    // MARK: - Loading
    func showLoading(timeout: TimeInterval = BaseRequest.timeOut(), customView: UIView? = nil, animated: Bool = true) {
        isLoading = true
        UIView.cancelPreviousPerformRequests(withTarget: self, selector: #selector(hideLoading(animated:)), object: nil)
        perform(#selector(hideLoading(animated:)), with: nil, afterDelay: timeout)
        BaseLoading.show(customView, animated: animated)
    }
    
    func showLoadingInView(_ view: UIView, timeout: TimeInterval = BaseRequest.timeOut(), customView: UIView? = nil, animated: Bool = true) {
        isLoading = true
        UIView.cancelPreviousPerformRequests(withTarget: self, selector: #selector(hideLoading(animated:)), object: nil)
        perform(#selector(hideLoading(animated:)), with: nil, afterDelay: timeout)
        BaseLoading.showInView(view: view, customView: customView, animated: animated)
    }
    
    @objc func hideLoading(animated: Bool = true) {
        isLoading = false
        BaseLoading.hide(animated: animated)
    }
}
extension UIViewController
{
    func showAlertControllerFromExtension(title: String, message: String, okTitle: String = "OK".localizedString().uppercased(), okAction: (() -> Void)?) {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: okTitle.uppercased(), style: .cancel) { (okButton) in
            okAction?()
        })
        self.present(alertController, animated: true, completion: nil)
    }
}

extension BaseViewController: UIGestureRecognizerDelegate {
    
    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let view = touch.view {
            if view is UIButton {
                return false
            }
        }
        
        return true
    }
}

extension BaseViewController {
    
    // MARK: - Interaction events
    func ignoringInteractionEvents(_ status: Bool) {
        if status {
            UIApplication.shared.beginIgnoringInteractionEvents()
        } else {
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}

extension BaseViewController {
    
    // MARK: - Keyboard notifications
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func destroyForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
    }
}

extension BaseViewController {
    
    // MARK: - Background mode
    func registerForBackgroundNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground(_:)), name: .UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive(_:)), name: .UIApplicationDidBecomeActive, object: nil)
    }
    
    func destroyForBackgroundNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIApplicationDidBecomeActive, object: nil)
    }
    
    @objc func willEnterForeground(_ notification: Notification) {
        
    }
    
    @objc func didBecomeActive(_ notification: Notification) {
        if isLoading {
            loading.startRotate()
        }
    }
}



