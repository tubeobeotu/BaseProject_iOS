//
//  HelperFunctions.swift
//  AppBuilder
//
//  Created by Lucio on 11/23/17.
//  Copyright © 2017 Lucio Pham. All rights reserved.
//

import Foundation

import UIKit

let APPSTORE_ID = ""

let APPSTORE_LINK = "https://itunes.apple.com/app/id\(APPSTORE_ID)"


func openOnAppstore() {
    if let url = URL(string: APPSTORE_LINK) {
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}


func openReviewOnAppstore() {
    let urlstring = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=\(APPSTORE_ID)&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software"
    if let url = URL(string: urlstring) {
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(url)
            }
        }
    }
}

func delay(_ delay: Double, closure: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

func getAvatarWithFacebookID(_ fbId: String) -> String {
    let avatar = "https://graph.facebook.com/\(fbId)/picture?type=large"
    return avatar
}



