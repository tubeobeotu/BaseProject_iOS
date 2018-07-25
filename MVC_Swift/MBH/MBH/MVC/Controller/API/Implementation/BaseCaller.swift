//
//  BaseCaller.swift
//  MBH
//
//  Created by tunv on 7/24/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation
class BaseCaller {
    func handleResult<T>(type: T.Type, input: APIResult) -> APICallerResult<T?>{
        switch(input){
        case .success(let response, _):
            return .success(response as? T) 
        case .networkError(let error):
            return .failure(error)
        case .failure(let error):
            return .failure(error)
        case .timedOut(let error):
            return .failure(error)
        }
    }
}
