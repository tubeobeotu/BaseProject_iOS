//
//  ApiMethod.swift
//  MBH
//
//  Created by tunv on 7/24/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation
import Alamofire
class ApiGetMethod: IApiMethod{
    func methodType() -> HTTPMethod {
        return .get
    }
}

class ApiPutMethod: IApiMethod{
    func methodType() -> HTTPMethod {
        return .put
    }
}

class ApiPostMethod: IApiMethod{
    func methodType() -> HTTPMethod {
        return .post
    }
}
