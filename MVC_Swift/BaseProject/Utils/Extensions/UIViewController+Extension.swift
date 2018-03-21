
import Foundation
import UIKit
//import MarqueeLabel
import KVLoading

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
    func back(_ sender: UIBarButtonItem) {
//        if(Preferences.shared().listOfSuppliesModelArr.count > 0){
//            Preferences.shared().listOfSuppliesModelArr.removeAll()
//        }

        if let viewcontroller = navigationController, viewcontroller.viewControllers.count > 1 {
            viewcontroller.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func openMenu(_ sender: UIBarButtonItem) {
        if let slideMenuController = self.slideMenuController() {
            slideMenuController.openLeft()
        }
    }
    
    func callSupportButtonAction(_ sender: UIBarButtonItem) {
//        let alertController = UIAlertController(title: "Call support", message: "Call 1900 1600", preferredStyle: UIAlertControllerStyle.alert)
//        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//        present(alertController, animated: true, completion: nil)
    }
    
    func reloadAction() {
        
    }

    func callSupportAction() {
        let alertController = UIAlertController(title: VTLocalizedString.localized(key: "callSupport").localizedString(), message: VTLocalizedString.localized(key: "call19001600").localizedString(), preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: VTLocalizedString.localized(key: "CÓ").localizedString(), style: UIAlertActionStyle.default, handler:{(alertAction) in
                if let url = URL(string: "tel://\(1789)"), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }))
        alertController.addAction(UIAlertAction(title: VTLocalizedString.localized(key: "KHÔNG").localizedString(), style: UIAlertActionStyle.default, handler:nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func viewInfoAction() {
        
    }

    func showQuickAccessInOutStation(_ sender: UIBarButtonItem){
        KVLoading.show()
        StationInOutManager.sharedInstance.autoDetectNotOutStation { (station: StationModel?) in
            KVLoading.hide()
            var controller: BaseNavigationController?
            if let model = station{
                controller = Storyboard.stationInOut.stationNavigationController() as BaseNavigationController
                let stationRootVC = controller?.viewControllers.first as! StationInOutInfoViewController
                stationRootVC.notOutStation = model
            } else {
                controller = Storyboard.stationInOut.stationNavigationController() as BaseNavigationController
            }
            
            if let slideMenuController = self.slideMenuController(), let controller = controller {
                slideMenuController.changeMainViewController(controller, close: true)
            }
        }
    }
}

extension BaseViewController {
    
    func addBroadcastNews() {
        BroadCastNewInfoModel.sharedInstance.convertToDisplayString { (attributeText) in
            if !attributeText.string.isEmpty {
                DispatchQueue.main.async {
                    let broadCastLabel = BroadCastNewInfoModel.sharedInstance.broadCastLabel
                    let filteredConstraints = self.view.constraints.filter { $0.identifier == "toplayout" }
                    if let yourConstraint = filteredConstraints.first  {
                        BroadCastNewInfoModel.sharedInstance.broadCastLabel.isHidden = false
                        let height = UIApplication.shared.statusBarFrame.height + CGFloat(self.navigationController?.navigationBar.frame.height ?? 0)
                        yourConstraint.constant = BroadCastNewInfoModel.sharedInstance.height
                        broadCastLabel.frame = CGRect(x: 0, y: height, width: UIScreen.main.bounds.width, height: BroadCastNewInfoModel.sharedInstance.height)
                        if !BroadCastNewInfoModel.sharedInstance.isAdded {
                            BroadCastNewInfoModel.sharedInstance.isAdded = true
                            //                    broadCastLabel.rate = 50
                            broadCastLabel.speed = .rate(50)
                            broadCastLabel.attributedText = attributeText
                            broadCastLabel.backgroundColor = .white
                            let bottomBorder = CALayer()
                            bottomBorder.frame =  CGRect(x: 0, y: height+BroadCastNewInfoModel.sharedInstance.height-1, width: UIScreen.main.bounds.width, height: 1)
                            bottomBorder.backgroundColor = UIColor.gray.cgColor
                            self.navigationController?.view.addSubview(broadCastLabel)
                            self.navigationController?.view.layer.addSublayer(bottomBorder)
                        }
                        
                    }else if(!self.isLeftMenu)
                    {
                        BroadCastNewInfoModel.sharedInstance.broadCastLabel.isHidden = true
                    }
                }
            }
        }
        
    }
    func hidenBroadcastLabel() {
        BroadCastNewInfoModel.sharedInstance.broadCastLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    }
    
    func addRoleLabel()
    {
        self.removeRoleLabel()
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 70))
        label.textColor = Constant.color.blueVSmart
        label.textAlignment = .center
        label.text = "Bạn không có quyền thực hiện thức năng này".localizedString()
        label.tag = 9876
        label.backgroundColor = UIColor.white
        self.view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        let top = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: BroadCastNewInfoModel.sharedInstance.height)
        let left = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 70)
        self.view.addConstraints([top, left, right, height])
        
        
    }
    func removeRoleLabel()
    {
        self.view.viewWithTag(9876)?.removeFromSuperview()
    }
    
    
}
