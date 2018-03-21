//
//  UIWindow+Extension.swift
//  AB Branded App
//
//  Created by Lucio on 3/14/18.
//  Copyright © 2018 Lucio Pham. All rights reserved.
//

import Foundation

extension UIWindow {
  
  func set(rootViewController newRootViewController: UIViewController, withTransition transition: CATransition? = nil) {
    
    let previousViewController = rootViewController
    
    if let transition = transition {
      // Add the transition
      layer.add(transition, forKey: kCATransition)
    }
    
    rootViewController = newRootViewController
    
    // Update status bar appearance using the new view controllers appearance - animate if needed
    if UIView.areAnimationsEnabled {
      UIView.animate(withDuration: CATransaction.animationDuration()) {
        newRootViewController.setNeedsStatusBarAppearanceUpdate()
      }
    } else {
      newRootViewController.setNeedsStatusBarAppearanceUpdate()
    }
    
    /// The presenting view controllers view doesn't get removed from the window as its currently transistioning and presenting a view controller
    if let transitionViewClass = NSClassFromString("UITransitionView") {
      for subview in subviews where subview.isKind(of: transitionViewClass) {
        subview.removeFromSuperview()
      }
    }
    if let previousViewController = previousViewController {
      // Allow the view controller to be deallocated
      previousViewController.dismiss(animated: false) {
        // Remove the root view in case its still showing
        previousViewController.view.removeFromSuperview()
      }
    }
  }
}
