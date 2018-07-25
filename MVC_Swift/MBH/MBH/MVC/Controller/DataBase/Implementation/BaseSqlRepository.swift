//
//  BaseSqlRepository.swift
//  MBH
//
//  Created by tunv on 7/25/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation
import RealmSwift

class BaseSqlRepository<K: ILocalModel>: IRepository {
    typealias T = K
   let middle = MiddleSqlRepository<T>()
    func insert(entity: T) {
        middle.insert(entity: entity)
    }
    
    func delete(entity: T) {
        middle.delete(entity: entity)
    }
    
    func update(entity: T, identifierNane: String, identifierValue: String) {
        middle.update(entity: entity, identifierNane: identifierNane, identifierValue: identifierValue)
    }
    
    func delete(query: IQueryable) {
        middle.delete(query: query)
    }
    
    func query(query: IQueryable) -> [T] {
        return middle.query(query: query)
    }
    
}
