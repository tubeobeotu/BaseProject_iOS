//
//  LogoAndSplashHelper.swift
//  AB Branded App
//
//  Created by Lucio on 2/22/18.
//  Copyright © 2018 Lucio Pham. All rights reserved.
//

import Foundation


let kSplashImage = "/SplashImage.jpg"
let kLogoImage = "/LogoImage.jpg"

class LogoAndSplashHelper {
  
  fileprivate static let fileManager = FileManager.default
  
  static var splashImageApp = #imageLiteral(resourceName: "splashStore")
  static var logoImageApp = #imageLiteral(resourceName: "logoStore")
    
  static func configSplashAndLogo() {
    
    let splashImagePath = documentDirectoryPath().appending(kSplashImage)
    let logoImagePath = documentDirectoryPath().appending(kLogoImage)
    
    if fileManager.fileExists(atPath: splashImagePath) && fileManager.fileExists(atPath: logoImagePath) {
      
      let splashImageUrl = URL(fileURLWithPath: splashImagePath)
      let logoImageUrl = URL(fileURLWithPath: logoImagePath)
      
      if let splashImage = UIImage(contentsOfFile: splashImageUrl.path),
        let logoImage = UIImage(contentsOfFile: logoImageUrl.path) {
        splashImageApp = splashImage
        logoImageApp = logoImage
      }
      
    }
    
  }
  
//  static func getUpdatedLogoAndSplash() -> (splashImage: UIImage, logoImage: UIImage)? {
//
//    let splashImagePath = documentDirectoryPath().appending(kSplashImage)
//    let logoImagePath = documentDirectoryPath().appending(kLogoImage)
//
//    if fileManager.fileExists(atPath: splashImagePath) && fileManager.fileExists(atPath: logoImagePath) {
//
//      let splashImageUrl = URL(fileURLWithPath: splashImagePath)
//      let logoImageUrl = URL(fileURLWithPath: logoImagePath)
//
//      if let splashImage = UIImage(contentsOfFile: splashImageUrl.path), let logoImage = UIImage(contentsOfFile: logoImageUrl.path) {
//        return (splashImage, logoImage)
//      } else {
//        return nil
//      }
//
//    } else {
//      return nil
//    }
//
//  }
  
  fileprivate static func downloadNewLogoAndSplashImage(_ splashImageURLString: String,
                                                        logoImageUrlString: String) {
    
    
    guard let encodingSplashUrlString = splashImageURLString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed), let encodingLogoUrlString = logoImageUrlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) else {
        return
    }
    
    
    if let splashURL = URL(string: encodingSplashUrlString),
      let logoURL = URL(string: encodingLogoUrlString) {
      DispatchQueue.global().async {
        if let splashData = try? Data(contentsOf: splashURL),
          let logoData = try? Data(contentsOf: logoURL) {
          
          fileManager.createFile(atPath: documentDirectoryPath().appending(kSplashImage), contents: splashData, attributes: nil)
          fileManager.createFile(atPath: documentDirectoryPath().appending(kLogoImage), contents: logoData, attributes: nil)
          
        }
      }
    }
    
  }
  
  static func updateLogoAndSplashPlist() {
    
    let plistPath = documentDirectoryPath().appending("/splashLogoURL.plist")
    
    guard let splashImageURLString = Store.currentStore?.splashImage,
      let logoImageUrlString = Store.currentStore?.logoImage else {
      return
    }
    
    if !fileManager.fileExists(atPath: plistPath) {
      //Create plist here
      let dictData = ["splashURL": splashImageURLString,
                  "logoURL": logoImageUrlString]
      
      _ = NSDictionary(dictionary: dictData).write(toFile: plistPath, atomically: true)
      
      downloadNewLogoAndSplashImage(splashImageURLString, logoImageUrlString: logoImageUrlString)
    } else {
      //Update plist here
      guard let plistFile = NSMutableDictionary(contentsOfFile: plistPath) else { return }
      
      if let splashUrl = plistFile.value(forKey: "splashURL") as? String,
        splashUrl != splashImageURLString {
        
        plistFile["splashURL"] = splashImageURLString
        plistFile.write(toFile: plistPath, atomically: true)
        
        downloadNewLogoAndSplashImage(splashImageURLString, logoImageUrlString: logoImageUrlString)
      } else if let logoUrl = plistFile.value(forKey: "logoURL") as? String, logoUrl != logoImageUrlString {
        
        plistFile["logoURL"] = logoImageUrlString
        plistFile.write(toFile: plistPath, atomically: true)
        downloadNewLogoAndSplashImage(splashImageURLString, logoImageUrlString: logoImageUrlString)
        
      }
      
    }
    
    
    
  }
  
  fileprivate static func documentDirectoryPath() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    return paths[0]
  }
  
}
