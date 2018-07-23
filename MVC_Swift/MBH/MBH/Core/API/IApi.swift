//
//  IApi.swift
//  MBH
//
//  Created by tunv on 7/23/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation

protocol IApi {
    static func timeOut() -> TimeInterval
    func fullUrl() -> URL?
    func baseUrlString() -> String
    func contextPathString() -> String
    func portString() -> String
    func path() -> String
    func method() -> IApiMethod
    func parameters() -> [String: Any]?
    func multipartBody() -> [Any]?
    func parameterEncoding() -> Any
    func headerFields() -> [String: String]?
    func uploadFiles() -> [IApiUploadFile]?
    
    func response(json: IApiOutput) -> Any?
    func request(completed: ((APIResult) -> Void)?)
}
