//
//  UIButton+Extension.swift
//  AB Branded App
//
//  Created by Nguyen Van Tu on 1/9/18.
//  Copyright © 2018 Lucio Pham. All rights reserved.
//

import Foundation

fileprivate let minimumHitArea = CGSize(width: 44, height: 44)
extension UIButton
{
    open override var isEnabled: Bool{
        didSet{
            self.alpha = isEnabled == false ? 0.5 : 1
        }
    }
  
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
      // if the button is hidden/disabled/transparent it can't be hit
      if self.isHidden || !self.isUserInteractionEnabled || self.alpha < 0.01 { return nil }
      
      // increase the hit frame to be at least as big as `minimumHitArea`
      let buttonSize = self.bounds.size
      let widthToAdd = max(minimumHitArea.width - buttonSize.width, 0)
      let heightToAdd = max(minimumHitArea.height - buttonSize.height, 0)
      let largerFrame = self.bounds.insetBy(dx: -widthToAdd / 2, dy: -heightToAdd / 2)
      
      // perform hit test on larger frame
      return (largerFrame.contains(point)) ? self : nil
    }
  
}
