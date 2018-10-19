//
//  BaseTabBarController.swift
//

import UIKit

class BaseTabBarController: UITabBarController {

    var isEnabledLeftPanGesture: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if !isEnabledLeftPanGesture, let slideMenuController = self.slideMenuController() {
//            slideMenuController.leftPanGesture?.isEnabled = false
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        if !isEnabledLeftPanGesture, let slideMenuController = self.slideMenuController() {
//            slideMenuController.leftPanGesture?.isEnabled = true
//        }
    }
}

extension BaseTabBarController {
    
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
        viewWillDisappear(true)
    }
    
    @objc func didBecomeActive(_ notification: Notification) {
        viewWillAppear(true)
    }
}
