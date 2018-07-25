//
//  AppObject.swift
//  Checking
//
//  Created by Tu NV on 6/13/18.
//  Copyright © 2018 Tu NV. All rights reserved.
//

import Foundation
import UIKit
enum AppState: Int{
    case loading
    case done
    case normal
}
enum CurrentVC: Int{
    case Login
    case ListStore
    case StoreDetail
}
class AppObject{
    // Can't init is singleton
    private init() { }
    private var numberOfLoadingTask = 0 {
        didSet{
            if(numberOfLoadingTask < 0){
                numberOfLoadingTask = 0
            }
            if(numberOfLoadingTask == 0){
                self.removeLoadingView()
            }else{
                self.addLoadingView()
            }
        }
    }
    var appState:AppState = .normal {
        didSet{
            if(self.appState == .loading){
                numberOfLoadingTask = numberOfLoadingTask + 1
            }else{
                numberOfLoadingTask = numberOfLoadingTask - 1
            }
            
        }
    }
    var curretVCType:CurrentVC = .Login
    var leftMenuSide:CGFloat = UIScreen.main.bounds.width * 0.9
    var userInfo = EZUserLocalModel(){
        didSet{
            print("")
        }
    }
    // MARK: Shared Instance
    
    static let shared = AppObject()
    
    private var loadingViewValue: UIView?
    private var loadingView: UIView {
        get {
            if loadingViewValue == nil {
                loadingViewValue = DefaultLoadingView()
            }
            
            return loadingViewValue!
        }
    }
    func updateUserInfo(){
//        let _ = DBManager.sharedInstance.updateUser(user: userInfo)
    }
    func addLoadingView(){
        if(loadingViewValue == nil){
            let screenSize = UIScreen.main.bounds.size
            let window = UIApplication.shared.keyWindow
            loadingView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
            window?.addSubview(loadingView)
        }
        
    }
    
    func removeLoadingView(){
        loadingViewValue?.removeFromSuperview()
        loadingViewValue = nil
    }
    
    func logOut(){
//        let idLocal = self.userInfo.idLocal
//        let userInfo = EZUserLocalModel()
//        userInfo.idLocal = idLocal
//
//        self.userInfo = userInfo
//        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//            appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
//            (appDelegate.window?.rootViewController as? UINavigationController)?.popToRootViewController(animated: true)
//        }
    }
}
