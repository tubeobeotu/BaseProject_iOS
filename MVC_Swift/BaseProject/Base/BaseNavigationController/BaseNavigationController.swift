//
//  BaseNavigationController.swift
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = Constant.color.blueVSmart
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: Constant.font.robotoBold(ofSize: 17)]
        
        navigationBar.tintColor = .white
        BroadCastNewInfoModel.sharedInstance.isAdded = false
    }
}
