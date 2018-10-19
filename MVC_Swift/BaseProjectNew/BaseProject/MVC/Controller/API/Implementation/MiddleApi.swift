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

class MiddleApi<T: JSONMappable>:IMiddleApi {
    func getModels(json: Any) -> [T] {
        if json is Data{
            var ezJson = EZJSON()
            ezJson.setJSON(json: json as! Data)
            print(ezJson)
            return [T](byJSON: ezJson)
        }
        return []
    }
    
    func getModel(json: Any) -> T {
        if json is Data{
            var ezJson = EZJSON()
            ezJson.setJSON(json: json as! Data)
            print(ezJson)
            return T.setup(byJSON: ezJson) as! T
        }
        return BaseDataModel() as! T
    }
}

