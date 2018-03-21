//
//  ErrorCodeDefine.swift
//  AB Branded App
//
//  Created by Lucio Pham on 1/31/18.
//  Copyright © 2018 Lucio Pham. All rights reserved.
//

import Foundation

struct ErrorCodeDefine {
  
  static func networkErrorCode(_ errorCode: String) -> String {
    
    guard let errorCode = Int(errorCode) else { return "Unknow Error"}
    
    var errorMessage = ""
    
    switch errorCode {
    case 12000:
      errorMessage = "Payment successfully sent."
    case 13000:
      errorMessage = "Invalid card number, please try again."
    case 13001:
      errorMessage = "Invalid card holder name, please try again."
    case 13002:
      errorMessage = "Invalid PIN code."
    case 13003:
      errorMessage = "Invalid PIN format."
    case 13004:
      errorMessage = "Invalid Expiry date."
    case 13005:
      errorMessage = "Invalid Zip Code."
    case 13006:
      errorMessage = "This card has been used by another account. Please try another card."
    case 13007:
      errorMessage = "You already added this card to your ChopOrder account. Please try another card."
    case 13008:
      errorMessage = "This card does not exist. Please try again."
    case 13009:
      errorMessage = "Promotion code is invalid"
    case 13010:
      errorMessage = "You already added this promotion code to your ChopOrder account. Please try another."
    case 13011:
      errorMessage = "You already added this code to your ChopOrder account. Please try another."
    case 13012:
      errorMessage = "Some problems occurred, you can not delete this promotion code at this time."
    case 13013:
      errorMessage = "This promotion code has not been added to your ChopOrder account."
    case 13014:
      errorMessage = "Cannot connect to your card provider service."
    case 13015:
      errorMessage = "Unable to validate your card information."
    case 14004:
      errorMessage = "Card expired. Please choose another card."
    case 14005:
      errorMessage = "Card inactive. Please choose another card."
    case 14006:
      errorMessage = "This transaction was declined. Please try again."
    case 14100:
      errorMessage = "Maximum number of attempts reached."
    case 14101:
      errorMessage = "Maximum amount exceeded for this card limit."
    case 15001:
      errorMessage = "Order not found."
    case 19001:
      errorMessage = "Incorrect login info. Please try again."
    case 19002:
      errorMessage = "Account is locked."
    case 19004:
      errorMessage = "Your account is suspended and is not permitted to access this feature."
    case 19006:
      errorMessage = "There is no account associated with this email address."
    case 19007:
      errorMessage = "Invalid country code."
    case 19008:
      errorMessage = "This number is already associated with another account."
    case 19009:
      errorMessage = "The verification code is incorrect. Please check again your SMS."
    case 19010:
      errorMessage = "The code needs to be 6-digit in length."
    case 19011:
      errorMessage = "Forgot password verification code is incorrect."
    case 19012:
      errorMessage = "This email address is already registered. Try logging in or use a different email."
    case 19013:
      errorMessage = "Please use only letters (a-z), numbers, hyphen and dash in your ChopOrder ID."
    case 19014:
      errorMessage = "Passwords don’t match. Please try again."
    case 19015:
      errorMessage = "Password length is invalid. Please enter 8 characters or longer."
    case 19016:
      errorMessage = "Missing special character. Please enter at least one number or symbol (like !@#$%^)"
    case 19017:
      errorMessage = "The photo you have selected is too large. The maximum size is 25MB."
    case 19018:
      errorMessage = "This OTP code has expired. Please try again."
    case 19019:
      errorMessage = "Account is inactive."
    case 19020:
      errorMessage = "Incorrect login info. Please try again."
    case 19021:
      errorMessage = "Invalid Email/Phone number format."
    case 19022:
      errorMessage = "Reset password verification code is expired."
    case 19023:
      errorMessage = "Some problems occurred, you can not change your password at this time."
    case 20001:
      errorMessage = "Store is deactivated."
    case 22001:
      errorMessage = "Another device login to your account"
    default:
      errorMessage = "Unknow Error"
    }
    
    return errorMessage.localized()
    
  }
  
}



