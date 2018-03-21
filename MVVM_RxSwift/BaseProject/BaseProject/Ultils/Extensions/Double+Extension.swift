//
//  Double+Extension.swift
//  AB Branded App
//
//  Created by Lucio on 2/26/18.
//  Copyright © 2018 Lucio Pham. All rights reserved.
//

import Foundation

extension Double {
  func rounded(toPlaces places:Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded() / divisor
  }
}
