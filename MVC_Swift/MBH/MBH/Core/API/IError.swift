//
//  IError.swift
//  MBH
//
//  Created by tunv on 7/23/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation
protocol IError {
    func getTitle() -> String?
    func getCode() -> Int
    func getErrorDescription() -> String?
    func getFailureReason() -> String?
}
