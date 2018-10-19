//
//  ApiOutput.swift
//  MBH
//
//  Created by tunv on 7/24/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation
struct ApiOutput: IApiOutput{
    var data: Data!
    func getRespose() -> Data {
        return data
    }
}
