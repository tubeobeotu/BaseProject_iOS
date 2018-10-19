//
//  UploadFile.swift
//  MBH
//
//  Created by tunv on 7/24/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation
struct UploadFile: IApiUploadFile
{
    var _data: Data! //Image data to upload
    var _name:String! //name of key
    var _fileName:String! //name of image file
    var _mineType:String! //type of image. ex: "image/jpeg"
    
    func data() -> Data {
        return _data
    }
    
    func name() -> String {
        return _name
    }
    
    func fileName() -> String {
        return _fileName
    }
    
    func mineType() -> String {
        return _mineType
    }
    
}
