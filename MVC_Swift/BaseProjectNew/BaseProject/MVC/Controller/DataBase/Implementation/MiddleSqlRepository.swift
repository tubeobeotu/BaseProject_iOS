//
//  MiddleSqlRepository.swift
//  MBH
//
//  Created by tunv on 7/25/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation
import RealmSwift
class MiddleSqlRepository<K: ILocalModel>: IRepository {
    typealias T = K
    
    func insert(entity: T) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(entity as! Object)
        }
    }
    
    func delete(entity: T) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(entity as! Object)
        }
    }
    
    func update(entity: T, identifierNane: String, identifierValue: String) {
        let realm = try! Realm()
        let entityFromRealms = realm.objects(T.self as! Object.Type).filter("\(identifierNane) = %@", identifierValue)
        var entityFromRealm = entityFromRealms.first
        if(entityFromRealm != nil){
            try! realm.write {
                entityFromRealm = (entity as! Object)
            }
        }
    }
    
    func delete(query: IQueryable) {
        let realm = try! Realm()
        let entityFromRealms = realm.objects(K.self as! Object.Type).filter(query.toStringQuery())
        let entityFromRealm = entityFromRealms.first
        if(entityFromRealm != nil){
            try! realm.write {
                realm.delete(entityFromRealm!)
            }
        }
    }
    
    func query(query: IQueryable) -> [T] {
        let realm = try! Realm()
        return Array(realm.objects(T.self as! Object.Type).filter(query.toStringQuery())) as! [T]
    }
    
}
