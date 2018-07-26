//
//  EZLoginBusiness.swift
//  MBH
//
//  Created by tunv on 7/25/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation
class EZLoginBusiness: BaseBusiness, IEZLoginBusiness {
    var localUser: ILocalModel!
    private lazy var db = UserSqlRepository()
    func saveUserToDB(user: EZUserLocalModel) {
        db.insert(entity: localUser as! EZUserLocalModel)
    }
    
    func saveTokenToDB(){
//        db.insert(entity: localUser)
    }
    
    
}
