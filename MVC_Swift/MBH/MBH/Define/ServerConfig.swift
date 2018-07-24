//
//  ServerConfig.swift
//  MBH
//
//  Created by tunv on 7/24/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation

struct ServerConfig {
    static let serverUrlTest = "http://localhost"
    static let serverPortTest = "8080"
    
    static let serverUrlLive = "http://kratos.ezsolution.vn"
    static let serverPortLive = "11080"
    
    static let requestTimeoutTestServer:TimeInterval = 60
    static let requestTimeoutLiveServer:TimeInterval = 60
}


struct OAuth{
    static let clientId = "kratos"
    static let clientSecret = "1528886251"
}


