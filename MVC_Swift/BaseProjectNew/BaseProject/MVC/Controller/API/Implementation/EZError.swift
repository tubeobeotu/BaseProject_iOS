//
//  EZError.swift
//  MBH
//
//  Created by tunv on 7/23/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation
class EZError: IError {
    func getTitle() -> String? {
        return title
    }
    
    func getCode() -> Int {
        return code
    }
    
    func getErrorDescription() -> String? {
        return _description
    }
    
    func getFailureReason() -> String? {
        return _description
    }
    
    var title = "Error"
    var code: Int
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    
    private var _description: String
    
    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
    }
    
    init(error: Error?) {
        self.code = 0
        if let error = error{
            self._description = error.localizedDescription
        }else{
            self._description = "UnKnown"
        }
    }
    init() {
        self.code = 0
        self._description = ""
    }
    static func setupNotInternet() -> EZError{
        let error = EZError()
        error.code = -1
        error._description = "Không có mạng"
        return error
    }
    
    static func setupRequestTimeout() -> EZError{
        let error = EZError()
        error.code = -2
        error._description = "Không phản hồi"
        return error
        
    }
}
