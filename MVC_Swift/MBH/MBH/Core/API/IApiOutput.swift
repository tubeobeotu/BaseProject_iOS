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
    func getJSON() -> JSON
}
