//
//  IRepository.swift
//  MBH
//
//  Created by tunv on 7/23/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation
protocol IRepository{
    associatedtype T
    func insert(entity: T)
    func delete(entity: T)
    func update(entity: T, identifierNane: String, identifierValue: String)
    func delete(query: IQueryable)
    func query(query: IQueryable) -> [T]
}
