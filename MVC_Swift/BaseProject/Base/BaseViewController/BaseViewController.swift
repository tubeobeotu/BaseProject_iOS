import UIKit
import KVLoading
import ReachabilitySwift
enum ContentState {
    case hasContent
    case loading
    case empty
    case error
}

class BaseViewController: UIViewController {

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
    
    lazy var reachability: Reachability = {
        let reachability = Reachability()
        return reachability!
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        view.backgroundColor = Constant.color.backgroundVSmart
        registerForBackgroundNotifications()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(!self.isLoadConfig)
        {
            configuration()
        }
        if enableNotification {
            addBroadcastNews()
        } else {
            hidenBroadcastLabel()
        }
        if let slideMenuController = self.slideMenuController() {
            slideMenuController.leftPanGesture?.isEnabled = isEnabledLeftPanGesture
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.touchOnScreen()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    deinit {
        destroyForBackgroundNotifications()
    }
}

extension BaseViewController {
    
    // MARK: - Actions
    func touchOnScreen() {
        view.endEditing(true)
    }
    
    func reloadData() {
        
    }
    
    func configuration() {
        
    }
    
    func continueAnimation() {
        loading.startRotate()
    }
}

extension BaseViewController {
    
    // MARK: - Loading
    func showLoading(timeout: TimeInterval = BaseRouter.timeOut, customView: UIView? = nil, animated: Bool = true) {
        isLoading = true
        UIView.cancelPreviousPerformRequests(withTarget: self, selector: #selector(hideLoading(animated:)), object: nil)
        perform(#selector(hideLoading(animated:)), with: nil, afterDelay: timeout)
        KVLoading.show(customView, animated: animated)
    }
    
    func showLoadingInView(_ view: UIView, timeout: TimeInterval = BaseRouter.timeOut, customView: UIView? = nil, animated: Bool = true) {
        isLoading = true
        UIView.cancelPreviousPerformRequests(withTarget: self, selector: #selector(hideLoading(animated:)), object: nil)
        perform(#selector(hideLoading(animated:)), with: nil, afterDelay: timeout)
        KVLoading.showInView(view: view, customView: customView, animated: animated)
    }
    
    func hideLoading(animated: Bool = true) {
        isLoading = false
        KVLoading.hide(animated: animated)
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
extension BaseViewController {
    
    // MARK: - Alerts
    func showAlertController(title: String, message: String, okTitle: String = "OK".localizedString().uppercased(), okAction: (() -> Void)?) {
        self.showAlertControllerFromExtension(title: title, message: message, okAction: okAction)
    }
    
    func showAlertController(title: String, message: String, cancelTitle: String = "Hủy bỏ".localizedString().uppercased(), cancelAction: (() -> Void)?, okTitle: String = "OK".localizedString().uppercased(), okAction: (() -> Void)?) {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: cancelTitle.uppercased(), style: .default) { (cancelButton) in
            cancelAction?()
        })
        alertController.addAction(UIAlertAction(title: okTitle.uppercased(), style: .default) { (cancelButton) in
            okAction?()
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertController(title: String, message: String, secureTextEntry: Bool = true, textfieldPlaceholder: String, keyboardType: UIKeyboardType = .default, cancelTitle: String = "Hủy bỏ".localizedString().uppercased(), cancelAction: (() -> Void)?, okTitle: String = "OK".localizedString().uppercased(), okAction: ((String) -> Void)?) {
        var inputTextField: UITextField?
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField { (textfield) in
            if secureTextEntry {
                textfield.isSecureTextEntry = true
            }
            textfield.placeholder = textfieldPlaceholder
            textfield.keyboardType = keyboardType
            textfield.borderStyle = .roundedRect
            inputTextField = textfield
        }
        alertController.addAction(UIAlertAction(title: cancelTitle.uppercased(), style: .default) { (cancelButton) in
            cancelAction?()
        })
        alertController.addAction(UIAlertAction(title: okTitle.uppercased(), style: .default) { (cancelButton) in
            if let password = inputTextField?.text {
                okAction?(password)
            }
        })
        self.present(alertController, animated: true, completion: nil)
        
        if let textFields = alertController.textFields {
            for textfield in textFields {
                let container = textfield.superview
                let effectView = container?.superview?.subviews[0]
                if effectView is UIVisualEffectView {
                    container?.backgroundColor = .clear
                    effectView?.removeFromSuperview()
                }
            }
        }
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
    
    func keyboardWillShow(_ notification: Notification) {
        
    }
    
    func keyboardWillHide(_ notification: Notification) {
        
    }
}

extension BaseViewController {

    // MARK: - Reachability
    func registerForReachabilityNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(_:)), name: ReachabilityChangedNotification, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {}
    }
    
    func destroyForReachabilityNotifications() {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: reachability)
    }
    
    func reachabilityChanged(_ notification: Notification) {
        
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
    
    func willEnterForeground(_ notification: Notification) {
        
    }
    
    func didBecomeActive(_ notification: Notification) {
        if isLoading {
            loading.startRotate()
        }
    }
}



