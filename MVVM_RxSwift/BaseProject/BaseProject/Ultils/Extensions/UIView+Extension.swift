//
//  UIView+Extension.swift
//  AppBuilder
//
//  Created by Lucio on 11/23/17.
//  Copyright © 2017 Lucio Pham. All rights reserved.
//

import Foundation

extension UIView {
  
  func constrainCentered(_ subview: UIView) {
    
    subview.translatesAutoresizingMaskIntoConstraints = false
    
    let verticalContraint = NSLayoutConstraint(
      item: subview,
      attribute: .centerY,
      relatedBy: .equal,
      toItem: self,
      attribute: .centerY,
      multiplier: 1.0,
      constant: 0)
    
    let horizontalContraint = NSLayoutConstraint(
      item: subview,
      attribute: .centerX,
      relatedBy: .equal,
      toItem: self,
      attribute: .centerX,
      multiplier: 1.0,
      constant: 0)
    
    let heightContraint = NSLayoutConstraint(
      item: subview,
      attribute: .height,
      relatedBy: .equal,
      toItem: nil,
      attribute: .notAnAttribute,
      multiplier: 1.0,
      constant: subview.frame.height)
    
    let widthContraint = NSLayoutConstraint(
      item: subview,
      attribute: .width,
      relatedBy: .equal,
      toItem: nil,
      attribute: .notAnAttribute,
      multiplier: 1.0,
      constant: subview.frame.width)
    
    addConstraints([
      horizontalContraint,
      verticalContraint,
      heightContraint,
      widthContraint])
    
  }
  
  func constrainToEdges(_ subview: UIView) {
    
    subview.translatesAutoresizingMaskIntoConstraints = false
    
    let topContraint = NSLayoutConstraint(
      item: subview,
      attribute: .top,
      relatedBy: .equal,
      toItem: self,
      attribute: .top,
      multiplier: 1.0,
      constant: 0)
    
    let bottomConstraint = NSLayoutConstraint(
      item: subview,
      attribute: .bottom,
      relatedBy: .equal,
      toItem: self,
      attribute: .bottom,
      multiplier: 1.0,
      constant: 0)
    
    let leadingContraint = NSLayoutConstraint(
      item: subview,
      attribute: .leading,
      relatedBy: .equal,
      toItem: self,
      attribute: .leading,
      multiplier: 1.0,
      constant: 0)
    
    let trailingContraint = NSLayoutConstraint(
      item: subview,
      attribute: .trailing,
      relatedBy: .equal,
      toItem: self,
      attribute: .trailing,
      multiplier: 1.0,
      constant: 0)
    
    addConstraints([
      topContraint,
      bottomConstraint,
      leadingContraint,
      trailingContraint])
  }
  
    // MARK: - Border
    @IBInspectable var borderColor: UIColor?{
        get {
            return UIColor(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor)
        }
        
        set{
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var border: CGFloat{
        get {
            return self.layer.borderWidth
        }
        
        set{
            self.layer.borderWidth = newValue
        }
    }
    
    // MARK: - Corners
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    // MARK: - Shadows
    @IBInspectable var shadowRadius: Double {
        get {
            return Double(self.layer.shadowRadius)
        }
        set {
            self.layer.shadowRadius = CGFloat(newValue)
        }
    }
    
    // The opacity of the shadow. Defaults to 0. Specifying a value outside the [0,1] range will give undefined results. Animatable.
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    // The shadow offset. Defaults to (0, -3). Animatable.
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    // The color of the shadow. Defaults to opaque black. Colors created from patterns are currently NOT supported. Animatable.
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor ?? UIColor.clear.cgColor)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    // Off - Will show shadow | On - Won't show shadow.
    @IBInspectable var masksToBounds: Bool {
        get {
            return self.layer.masksToBounds
        }
        
        set {
            self.layer.masksToBounds = newValue
        }
    }
    
    func makeCircle() {
        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true
    }
    
    func borderDefault() {
        self.border = 1
        self.cornerRadius = 4
        self.borderColor = AppColor.borderColor.value
//        self.backgroundColor = UIColor.clear
    }
    
    func dashBorder(bound: CGRect)
    {
        let border = CAShapeLayer()
        border.strokeColor = AppColor.borderColor.value.cgColor
        border.lineDashPattern = [2, 2]
        border.frame = self.bounds
        border.fillColor = nil
        border.path = UIBezierPath(rect: bound).cgPath
        self.layer.addSublayer(border)
    }
    func addDashedBorder(strokeColor: UIColor = AppColor.borderColor.value, lineWidth: CGFloat = 1) {
        self.layoutIfNeeded()
        let strokeColor = strokeColor.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: 1)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = strokeColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = kCALineJoinRound
        
        shapeLayer.lineDashPattern = [2,2] // adjust to your liking
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: frameSize.width, y: 0))
        
        shapeLayer.path = path.cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    func setCircle()
    {
        layer.cornerRadius = 0.5 * bounds.size.width
        clipsToBounds = true
    }
}
