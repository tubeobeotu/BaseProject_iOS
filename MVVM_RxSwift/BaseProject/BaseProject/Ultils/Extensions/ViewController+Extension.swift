//
//  ViewController+Extension.swift
//  AppBuilder
//
//  Created by Lucio on 11/23/17.
//  Copyright © 2017 Lucio Pham. All rights reserved.
//

import Foundation

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}



//Tea
extension UIViewController
{
    static func getTopVC() -> UIViewController?
    {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    func removeLeftNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
    }
    func removeRightNavigationBarItem() {
        self.navigationItem.rightBarButtonItem = nil
    }
    
    func addCloseNavigationButton()
    {
        let leftButton = UIBarButtonItem.init(image: UIImage.init(named: "Close_Icon"), style: .plain, target: self, action: #selector(leftAction))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    func addCloseNavigationButtonDemo() -> UIBarButtonItem
    {
        let leftButton = UIBarButtonItem()
        leftButton.image = #imageLiteral(resourceName: "Close_Icon")
        self.navigationItem.leftBarButtonItem = leftButton
        return leftButton
    }
    
    
    @objc func leftAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getSafeLayout() -> SafeLayout
    {
        if #available(iOS 11.0, *) {
            let top = self.view.safeAreaInsets.top + UIApplication.shared.statusBarFrame.height +
                (self.navigationController?.navigationBar.frame.height ?? 0)
            let bottom = self.view.safeAreaInsets.bottom
            return SafeLayout.init(top: top, bottom: bottom)
        } else {
            return SafeLayout.init(top: UIApplication.shared.statusBarFrame.size.height, bottom: 0)
        }
    }
    
}

struct SafeLayout
{
    var top: CGFloat = 0
    var bottom: CGFloat = 0
}

