//
//  UIImage+Extension.swift
//  AB Branded App
//
//  Created by Lucio Pham on 1/5/18.
//  Copyright © 2018 Lucio Pham. All rights reserved.
//

import Foundation

extension UIImage {
    
    func mask(with color: UIColor = AppColor.secondaryColor.value) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.clip(to: rect, mask: cgImage!)
        
        color.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func scaleToSize(aSize :CGSize) -> UIImage {
        if (self.size.equalTo(aSize)) {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(aSize, false, 0.0)
        self.draw(in: CGRect.init(x: 0.0, y: 0.0, width: aSize.width, height: aSize.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
