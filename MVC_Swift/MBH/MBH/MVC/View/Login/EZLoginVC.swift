//
//  EZLoginVC.swift
//  MBH
//
//  Created by tunv on 7/24/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import UIKit

class EZLoginVC: BaseViewController {
    lazy var caller = ApiLoginCaller()
    lazy var business = EZLoginBusiness()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        self.login(userName: "tunv@ezsolution.vn111", password: "Tu123456")
    }
    
    func login(userName: String, password: String){
    
        caller.login(type: Token.self, username: userName, password: password) { (result) in
            switch(result){
            case .success(let model):
               self.business.doSomeThing()
                break
            case .failure(let error):
                self.handleError(error: error)
                break
            }
        }
    }
}
