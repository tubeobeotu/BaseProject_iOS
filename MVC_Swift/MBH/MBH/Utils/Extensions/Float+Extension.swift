//
//  Float+Extension.swift
//

import Foundation

extension Float {
    
    func toBase64EncodedString() -> String {
        var float: Float = self
        let floatData = Data(buffer: UnsafeBufferPointer(start: &float, count: 1))
        return floatData.base64EncodedString()
    }

}
