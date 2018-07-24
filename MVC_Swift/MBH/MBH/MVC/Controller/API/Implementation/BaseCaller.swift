//
//  BaseCaller.swift
//  MBH
//
//  Created by tunv on 7/24/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation
class BaseCaller {
    func handleResult<T>(input: APIResult) -> APICallerResult<T>{
        switch(input){
        case .success(let response, _):
            return APICallerResult<T>.success(response as? T)
        case .networkError(let error):
            return APICallerResult<T>.failure(error)
        case .failure(let error):
            return APICallerResult<T>.failure(error)
        case .timedOut(let error):
            return APICallerResult<T>.failure(error)
        }
    }
}
