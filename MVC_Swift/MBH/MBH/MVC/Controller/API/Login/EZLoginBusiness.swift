//
//  EZLoginBusiness.swift
//  MBH
//
//  Created by tunv on 7/25/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation

class EZLoginBusiness: BaseBusiness, IEZLoginBusiness {
    internal var localUser: ILocalModel
    
    init(localUser: ILocalModel) {
        self.localUser = localUser
    }
    private lazy var db = UserSqlRepository()
    func saveUserToDB(user: EZUserLocalModel) {
        db.insert(entity: localUser as! EZUserLocalModel)
    }
    
    func saveTokenToDB(){
        print("Saved token")
//        db.insert(entity: localUser)
    }
    
    
}
