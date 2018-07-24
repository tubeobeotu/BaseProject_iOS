//
//  EZUserLocalModel.swift
//  Checking
//
//  Created by Tu NV on 6/27/18.
//  Copyright © 2018 Tu NV. All rights reserved.
//

import Foundation
import RealmSwift
class EZUserLocalModel: Object {
    @objc dynamic var localId = ""
    @objc dynamic var accessToken = ""
    @objc dynamic var refreshToken = ""
    @objc dynamic var tokenType = ""
    @objc dynamic var districtId = ""
    @objc dynamic var stateId = ""
    
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var phoneNumber = ""
    @objc dynamic var createdAt = ""
    @objc dynamic var createdBy = ""
    @objc dynamic var updatedAt = ""
    @objc dynamic var updatedBy = ""
    @objc dynamic var status = ""
    @objc dynamic var streetId = ""
    
    @objc dynamic var stateName = ""
    @objc dynamic var districtName = ""
    

    convenience init(localId: String,
         accessToken: String,
         refreshToken: String,
         tokenType: String,
         districtId: String,
         districtName: String,
         stateId: String,
         stateName: String,
         id: String,
         name: String,
         phoneNumber: String,
         createdAt: String,
         createdBy: String,
         updatedAt: String,
         updatedBy: String,
         status: String,
         streetId: String) {
        self.init()
        self.stateName = stateName
        self.districtName = districtName
        self.localId = localId
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.tokenType = tokenType
        self.districtId = districtId
        self.stateId = stateId
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.createdAt = createdAt
        self.createdBy = createdBy
        self.updatedAt = updatedAt
        self.updatedBy = updatedBy
        self.status = status
        self.streetId = streetId
    }
}
