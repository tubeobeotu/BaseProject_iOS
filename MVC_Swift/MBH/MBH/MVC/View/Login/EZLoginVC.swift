//
//  EZLoginVC.swift
//  MBH
//
//  Created by tunv on 7/24/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import UIKit
import Swinject
class EZLoginVC: BaseViewController {
    lazy var caller = ApiLoginCaller()
    let container = Container()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        self.login(userName: "tunv@ezsolution.vn111", password: "Tu123456")
    }
    
    func login(userName: String, password: String){
    
        caller.login(type: EZTokenModel.self, username: userName, password: password) {[weak self] (result) in
            switch(result){
            case .success(let model):
                
                self?.container.register(EZLoginBusiness.self) { r in EZLoginBusiness() }
                    .initCompleted { r, c in c.localUser = r.resolve(ILocalModel.self)! }
                self?.container.register(ILocalModel.self) { _ in EZTokenModel() }
                let business = self?.container.resolve(EZLoginBusiness.self)!
                business?.saveTokenToDB()
               
                break
            case .failure(let error):
                self?.handleError(error: error)
                break
            }
        }
    }
}
