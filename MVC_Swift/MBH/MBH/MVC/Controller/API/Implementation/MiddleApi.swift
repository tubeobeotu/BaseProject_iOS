//
//  MiddleApi.swift
//  MBH
//
//  Created by tunv on 7/24/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation
import SwiftyJSON
protocol IMiddleApi {
    associatedtype T
    func getModels(json: Any) -> [T]
    func getModel(json: Any) -> T
}

class MiddleApi<T: SwiftyJSONMappable>:IMiddleApi {
    func getModels(json: Any) -> [T] {
        if json is Data{
            do {
                let rawJson = try JSON(data: json as! Data)
                return [T](byJSON: rawJson)
            } catch {
                return []
            }
        }
        return []
    }
    
    func getModel(json: Any) -> T {
        if json is Data{
            do {
                let rawJson = try JSON(data: json as! Data)
                return T.setup(byJSON: rawJson) as! T
            } catch {
                return BaseDataModel() as! T
            }
        }
        return BaseDataModel() as! T
    }
}

