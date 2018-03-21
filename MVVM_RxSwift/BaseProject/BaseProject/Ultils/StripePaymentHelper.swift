//
//  StripePaymentHelper.swift
//  AB Branded App
//
//  Created by Lucio Pham on 1/24/18.
//  Copyright © 2018 Lucio Pham. All rights reserved.
//

import Foundation
//import Stripe

class StripePaymentHelper {
  
  static func cardBrand(from brand: STPCardBrand) -> String {
    switch brand {
    case .visa:
      return "Visa"
    case .amex:
      return "Amex"
    case .masterCard:
      return "MasterCard"
    case .discover:
      return "Discover"
    case .JCB:
      return "JCB"
    case .dinersClub:
      return "DinersClub"
    case .unknown:
      return "Unknow"
    }
  }
  
  static func cardImage(from brand: String) -> UIImage {
    switch brand.lowercased() {
    case "visa":
      return STPImageLibrary.visaCardImage()
    case "amex":
      return STPImageLibrary.amexCardImage()
    case "mastercard":
      return STPImageLibrary.masterCardCardImage()
    case "discover":
      return STPImageLibrary.discoverCardImage()
    case "jcb":
      return STPImageLibrary.jcbCardImage()
    case "dinersclub":
      return STPImageLibrary.dinersClubCardImage()
    default:
      return STPImageLibrary.unknownCardCardImage()
    }
  }
  
}
