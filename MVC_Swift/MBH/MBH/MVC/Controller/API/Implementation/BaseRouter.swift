//
//  BaseRouter.swift
//
import Foundation
import SwiftyJSON
import Alamofire
import UIKit

//Using Alamofire
enum SV_VT: NSInteger
{
    case Dump_SV
    case Live_SV
}


class BaseRouter{
        func fullUrl() -> URL? {
            return  URL.init(string:"\(baseUrlString()):\(portString())\(contextPathString())\(path())")
//            switch(BaseRouter.SERVER)
//            {
//            case .Dump_SV:
//                return  URL.init(string: "\(baseUrlString())\(contextPathString())\(path())")
//            case .Live_SV:
//                return URL.init(string:"\(baseUrlString()):\(portString())\(contextPathString())\(path())")
//            }
        }
    
        func baseUrlString() -> String {
            switch(BaseRequest.SERVER)
            {
            case .Dump_SV:
                return ServerConfig.serverUrlTest
            case .Live_SV:
                return ServerConfig.serverUrlLive
            }
        }
    
        func contextPathString() -> String  {
            switch(BaseRequest.SERVER)
            {
            case .Dump_SV:
                return "/api/"
            case .Live_SV:
                return "/api/"
            }
        }
    
        func portString() -> String {
            switch(BaseRequest.SERVER)
            {
            case .Dump_SV:
                return ServerConfig.serverPortTest
            case .Live_SV:
                return ServerConfig.serverPortLive
            }
        }
    
        func path() -> String {
            fatalError("[\(#function))] Must be overridden in subclass")
        }
    
        func method() -> IApiMethod {
            fatalError("[\(#function))] Must be overridden in subclass")
        }
    
        func parameters() -> [String : Any]? {
            return nil
        }
    
        func multipartBody() -> [Any]? {
            return nil
        }
    
        func parameterEncoding() -> Any {
            fatalError("[\(#function))] Must be overridden in subclass")
        }
    
        func headerFields() -> [String : String]? {
            return nil
        }
    
        func uploadFiles() -> [IApiUploadFile]? {
            return nil
        }
    
        func response(data: IApiOutput) -> Any? {
            return nil
        }
}
