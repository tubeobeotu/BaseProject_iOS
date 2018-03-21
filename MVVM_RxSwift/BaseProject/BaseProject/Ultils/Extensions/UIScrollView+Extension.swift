//
//  UIScrollView+Extension.swift
//  AB Branded App
//
//  Created by Lucio on 3/9/18.
//  Copyright © 2018 Lucio Pham. All rights reserved.
//

import Foundation

extension UIScrollView {
  
  func  isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
    return self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
  }
  
}
