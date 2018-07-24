//
//  UserSqlRepository.swift
//  MBH
//
//  Created by tunv on 7/24/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation
import RealmSwift
class UserSqlRepository: IRepository {
    typealias T = EZUserLocalModel
    func insert(entity: EZUserLocalModel) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(entity)
        }
    }
    
    
    func update(entity: EZUserLocalModel) {
        let realm = try! Realm()
        let entityFromRealms = realm.objects(EZUserLocalModel.self).filter("localId = %@", entity.localId)
        var entityFromRealm = entityFromRealms.first
        if(entityFromRealm != nil){
            try! realm.write {
                entityFromRealm = entity
            }
        }
    }
    
    func delete(entity: EZUserLocalModel) {
        let realm = try! Realm()
        try! realm.write {
           realm.delete(entity)
        }
    }
    
    func delete(query: IQueryable) {
        let realm = try! Realm()
        let entityFromRealms = realm.objects(EZUserLocalModel.self).filter(query.toStringQuery())
        let entityFromRealm = entityFromRealms.first
        if(entityFromRealm != nil){
            try! realm.write {
                realm.delete(entityFromRealm!)
            }
        }
    }
    
    
    
    func query(query: IQueryable) -> [EZUserLocalModel] {
        let realm = try! Realm()
        return Array(realm.objects(EZUserLocalModel.self).filter(query.toStringQuery()))
    }
    
    
}
