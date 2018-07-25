//
//  EZLoginVC.swift
//  MBH
//
//  Created by tunv on 7/24/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import UIKit

class EZLoginVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        self.login(userName: "tunv@ezsolution.vn", password: "Tu123456")
    }
    
    func login(userName: String, password: String){
        let test = ApiLoginCaller()
        test.login(type: Token.self, username: userName, password: password) { (result) in
            switch(result){
            case .success(let model):
                print(model?.accessToken ?? "")
                break
            case .failure(let error):
                self.handleError(error: error)
                break
            }
        }
    }
}
