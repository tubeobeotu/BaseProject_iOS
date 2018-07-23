//
//  BaseAlertView
//

//let verificationAlertView = BaseAlertView(contentView: warningInfo)
////        verificationAlertView.isHiddenWhenTouchOnBackScreen = false
//verificationAlertView.showInView(self.masterView, execute: {
//    
//})
//warningInfo.rejectClosure = { sender in
//    verificationAlertView.dismiss()
//}
//warningInfo.updateClosure = {object, sender in
//    verificationAlertView.dismiss()
//    self.updateWarningInfo(warningInfo: object)
//}

import UIKit

class BaseAlertView: UIView {
    var isHiddenWhenTouchOnBackScreen = false
    private let backgroundTransparency: CGFloat = 0.2
    private var alertWidth: CGFloat = 224.0
    private var alertHeight: CGFloat = 128.0
    private var keyboardHeight: CGFloat = 0.0
    
    fileprivate lazy var blurView: UIView = {
        let blurView = UIView()
        blurView.backgroundColor = UIColor(white: 0, alpha: 0)
        return blurView
    }()
    
    lazy var keyView: UIView = {
        if let view = UIApplication.shared.keyWindow {
            return view
        }
        
        return UIView()
    }()
    
    var customKeyView: UIView?
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        autoresizingMask = [.flexibleHeight, .flexibleWidth]
        backgroundColor = .clear
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    convenience init(contentView: UIView) {
        self.init()
        alertWidth = contentView.bounds.size.width
        alertHeight = contentView.bounds.size.height
        contentView.frame = contentView.bounds
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: alertWidth, height: alertHeight)
        addSubview(contentView)
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardRectValue = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardRectValue.height
            if let customKeyView = customKeyView {
                frame.origin.y = customKeyView.bounds.size.height / 2.0 - bounds.size.height / 2.0 - keyboardHeight / 2.0
            } else {
                frame.origin.y = keyView.bounds.size.height / 2.0 - bounds.size.height / 2.0 - keyboardHeight / 2.0
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if let customKeyView = customKeyView {
            frame.origin.y = customKeyView.bounds.size.height / 2.0 - bounds.size.height / 2.0
        } else {
            frame.origin.y = keyView.bounds.size.height / 2.0 - bounds.size.height / 2.0
        }
    }
    
    func setContentView(_ contentView: UIView) {
        alertWidth = contentView.bounds.size.width
        alertHeight = contentView.bounds.size.height
        contentView.frame = contentView.bounds
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: alertWidth, height: alertHeight)
        addSubview(contentView)
    }
    
    func show(execute closure: (() -> Void)? = nil) {
        blurView.frame = UIScreen.main.bounds
        center = blurView.center
        keyView.addSubview(blurView)
        blurView.addSubview(self)
        
        self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.alpha = self.backgroundTransparency
        self.blurView.backgroundColor = UIColor(white: 0, alpha: 0)
        self.addDismisViewGesture()
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = .identity
            self.alpha = 1.0
            self.blurView.backgroundColor = UIColor(white: 0, alpha: self.backgroundTransparency)
        }) { (finished) in
            closure?()
        }
    }
    
    func showInView(_ view: UIView, execute closure: (() -> Void)? = nil) {
        customKeyView = view
        blurView.frame = UIScreen.main.bounds
        center = blurView.center
        customKeyView?.addSubview(blurView)
        blurView.addSubview(self)
        self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.alpha = self.backgroundTransparency
        self.blurView.backgroundColor = UIColor(white: 0, alpha: 0)
        self.addDismisViewGesture()
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = .identity
            self.alpha = 1.0
            self.blurView.backgroundColor = UIColor(white: 0, alpha: self.backgroundTransparency)
        }) { (finished) in
            closure?()
        }
    }
    
    func dismiss(execute closure: (() -> Void)? = nil) {
        transform = .identity
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.alpha = 0
            self.blurView.alpha = 0
        }) { (finished) in
            self.customKeyView = nil
            self.removeFromSuperview()
            self.blurView.removeFromSuperview()
            closure?()
        }
    }
}

extension BaseAlertView: UIGestureRecognizerDelegate
{
    func addDismisViewGesture()
    {
        if(self.isHiddenWhenTouchOnBackScreen)
        {
            let tap = UITapGestureRecognizer.init(target: self, action:#selector(dismissView(sender:)))
            tap.delegate = self
            self.blurView.addGestureRecognizer(tap)
        }
        
    }
    @objc func dismissView(sender: UITapGestureRecognizer? = nil) {
        self.dismiss()
    }
}

