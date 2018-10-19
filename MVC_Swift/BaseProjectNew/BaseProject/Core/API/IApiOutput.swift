//
//  IApiOutput.swift
//  MBH
//
//  Created by tunv on 7/23/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation
import SwiftyJSON
protocol IApiOutput {
    func getRespose() -> Data
}

enum APIResult {
    case success(Any?, Any?)
    case failure(IError)
    case timedOut(IError)
    case networkError(IError)
}

enum APICallerResult<T>{
    case success(T?)
    case failure(IError)
}
