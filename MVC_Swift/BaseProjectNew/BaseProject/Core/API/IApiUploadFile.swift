//
//  IApiUploadFile.swift
//  MBH
//
//  Created by tunv on 7/23/18.
//  Copyright © 2018 tunv. All rights reserved.
//

import Foundation
protocol IApiUploadFile {
    func data() -> Data //Image data to upload
    func name() -> String //name of key
    func fileName() -> String //name of image file
    func mineType() -> String //type of image. ex: "image/jpeg"
}
