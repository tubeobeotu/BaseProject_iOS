//
//  Error+Rx.swift
//  AB Branded App
//
//  Created by Lucio Pham on 12/22/17.
//  Copyright © 2017 Lucio Pham. All rights reserved.
//

import Foundation

extension Observable where Element == Error {
  
  func transformErrorType() -> Observable<ABError> {
    return self.map({ (error) in
     
      if let error = error as? MoyaError, let errorResponse = error.response {
        
        do {
          let abError = try errorResponse.mapObject(ABError.self)
          
          return abError
        } catch {
          return ABError("\(errorResponse.statusCode)", message: error.localizedDescription)
        }
        
      }
      
      return ABError(nil, message: "Unknow Error")
      
    })
  }
  
}
