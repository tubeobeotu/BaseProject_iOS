
import Foundation
import UIKit
//import MarqueeLabel

enum ItemPosition {
    case left, right
}

enum ItemType {
    case back, leftMenu, rightReload, rightCallSupport, rightViewInfo
}
extension UIViewController {
    
    func navigationBarButtonItems(_ items: [(ItemType, ItemPosition)]?) {
        self.navigationItem.rightBarButtonItems = nil
        self.navigationItem.leftBarButtonItems = nil
        
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(back(_:)))
        self.navigationItem.backBarButtonItem = backButtonItem
        
        guard let items = items else {
            return
        }
        
        var rightBarButtonItems: [UIBarButtonItem] = [UIBarButtonItem]()
        var leftBarButtonItems: [UIBarButtonItem] = [UIBarButtonItem]()
        
        for (key, value) in items {
            var item: UIBarButtonItem?
            switch key {
            case .back:
                let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
                backButton.setImage(UIImage(named: "back-icon"), for: .normal)
                backButton.showsTouchWhenHighlighted = true
                backButton.addTarget(self, action: #selector(back(_:)), for: .touchUpInside)
                backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0)
                let backItem = UIBarButtonItem(customView: backButton)
                item = backItem
                
            case .leftMenu:
                let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
                menuButton.setImage(UIImage(named: "menu-icon"), for: .normal)
                menuButton.showsTouchWhenHighlighted = true
                menuButton.addTarget(self, action: #selector(openMenu(_:)), for: .touchUpInside)
                menuButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0)
                let menuItem = UIBarButtonItem(customView: menuButton)
                item = menuItem
                
            case .rightReload:
                let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: (self.navigationController?.navigationBar.frame.height)!))
                backButton.setImage(UIImage(named: "reload-icon"), for: .normal)
                backButton.showsTouchWhenHighlighted = true
                backButton.addTarget(self, action: #selector(reloadAction), for: .touchUpInside)
                backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
                let backItem = UIBarButtonItem(customView: backButton)
                item = backItem
                
            case .rightCallSupport:
                let callSupportButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: (self.navigationController?.navigationBar.frame.height)!))
                callSupportButton.setImage(UIImage(named: "call-support-icon"), for: .normal)
                callSupportButton.showsTouchWhenHighlighted = true
                callSupportButton.addTarget(self, action: #selector(callSupportAction), for: .touchUpInside)
                callSupportButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
                let callSupportItem = UIBarButtonItem(customView: callSupportButton)
                item = callSupportItem
                
            case .rightViewInfo:
                let viewInfoButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: (self.navigationController?.navigationBar.frame.height)!))
                viewInfoButton.setImage(UIImage(named: "view-info-icon"), for: .normal)
                viewInfoButton.showsTouchWhenHighlighted = true
                viewInfoButton.addTarget(self, action: #selector(viewInfoAction), for: .touchUpInside)
                viewInfoButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
                let viewInfoItem = UIBarButtonItem(customView: viewInfoButton)
                item = viewInfoItem
            
            }
            
            guard let guardItem = item else {
                continue
            }
            
            switch value {
            case .right:
                rightBarButtonItems.append(guardItem)
                
            case .left:
                leftBarButtonItems.append(guardItem)
            }
        }
        
        self.navigationItem.setRightBarButtonItems(rightBarButtonItems, animated: false)
        self.navigationItem.setLeftBarButtonItems(leftBarButtonItems, animated: false)
    }

}

extension UIViewController {
    
    // MARK: - Actions
    @objc func back(_ sender: UIBarButtonItem) {
//        if(Preferences.shared().listOfSuppliesModelArr.count > 0){
//            Preferences.shared().listOfSuppliesModelArr.removeAll()
//        }

        if let viewcontroller = navigationController, viewcontroller.viewControllers.count > 1 {
            viewcontroller.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func openMenu(_ sender: UIBarButtonItem) {

    }
    
    func callSupportButtonAction(_ sender: UIBarButtonItem) {
//        let alertController = UIAlertController(title: "Call support", message: "Call 1900 1600", preferredStyle: UIAlertControllerStyle.alert)
//        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//        present(alertController, animated: true, completion: nil)
    }
    
    @objc func reloadAction() {
        
    }

    @objc func callSupportAction() {
        let alertController = UIAlertController(title:  "callSupport".localizedString(), message: "call19001600".localizedString(), preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "CÓ".localizedString(), style: UIAlertActionStyle.default, handler:{(alertAction) in
                if let url = URL(string: "tel://\(1789)"), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }))
        alertController.addAction(UIAlertAction(title: "KHÔNG".localizedString(), style: UIAlertActionStyle.default, handler:nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func viewInfoAction() {
        
    }

}

