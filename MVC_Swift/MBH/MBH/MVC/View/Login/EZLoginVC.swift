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
                if let model = model{
                    self?.saveToken(token: model)
                }
                break
            case .failure(let error):
                 self?.saveToken(token: nil)
                self?.handleError(error: error)
                break
            }
        }
    }
    
    func saveToken(token: EZTokenModel?){
        container.register(IEZLoginBusiness.self) { r in EZLoginBusiness.init(localUser: r.resolve(ILocalModel.self)!)}
        container.register(ILocalModel.self) { _ in EZTokenModel() }
            .initCompleted { r, c in
        }
    
        let business = container.resolve(IEZLoginBusiness.self) as! EZLoginBusiness
        business.saveTokenToDB()
    }
}
