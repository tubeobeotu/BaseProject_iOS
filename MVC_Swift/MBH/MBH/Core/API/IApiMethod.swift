//
//  IApiMethod.swift
//  MBH
//
//  Created by tunv on 7/23/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation
import Alamofire
protocol IApiMethod {
    func methodType ()-> HTTPMethod
}
