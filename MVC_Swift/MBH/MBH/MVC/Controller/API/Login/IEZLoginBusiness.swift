//
//  IEZLoginBusiness.swift
//  MBH
//
//  Created by tunv on 7/26/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation
protocol IEZLoginBusiness {
    var localUser: ILocalModel{get set}
    func saveUserToDB(user: EZUserLocalModel)
    func saveTokenToDB()
}
