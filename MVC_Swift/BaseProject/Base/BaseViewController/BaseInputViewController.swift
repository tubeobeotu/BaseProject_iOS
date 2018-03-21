//
//  BaseInputViewController.swift
//  VSmart
//
//  Created by Hiep Le Dinh on 12/13/17.
//  Copyright © 2017 ITSOL. All rights reserved.
//

import UIKit

struct Constants {
    
    struct KeyboardAnimation {
        static let duration = 0.3
        static let minimumScrollFraction: CGFloat = 0.2
        static let maximumScrollFraction: CGFloat = 0.8
    }
    
    static let keyboardHeight: CGFloat = 216.0
}

class BaseInputViewController: BaseViewController {
    
    var animatedDistance: CGFloat = 0
    var animatedDistanceHeight1: CGFloat = 0
    var animatedDistanceHeight2: CGFloat = 0
    
    @IBOutlet var textFields: [UITextField]!
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
}

extension BaseInputViewController : UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        let textFieldRect = self.view.window?.convert(textField.bounds, from: textField)
        let viewRect = self.view.window?.convert(self.view.bounds, from: self.view)
        
        let middleLine = textFieldRect!.origin.y + 0.5 * textFieldRect!.size.height
        let numerator = middleLine - viewRect!.origin.y - Constants.KeyboardAnimation.minimumScrollFraction * viewRect!.size.height
        let denominator = (Constants.KeyboardAnimation.maximumScrollFraction - Constants.KeyboardAnimation.minimumScrollFraction) * viewRect!.size.height
        var heightFraction = numerator / denominator
        
        if heightFraction < 0.0 {
            heightFraction = 0.0
        } else if heightFraction > 1.0 {
            heightFraction = 1.0
        }
        
        self.animatedDistance = floor(Constants.keyboardHeight * heightFraction)
        
        var viewFrame = self.view.frame
        viewFrame.origin.y -= self.animatedDistance
                
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(Constants.KeyboardAnimation.duration)
        self.view.frame = viewFrame
        UIView.commitAnimations()
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        var viewFrame = self.view.frame
        viewFrame.origin.y += self.animatedDistance
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(Constants.KeyboardAnimation.duration)
        self.view.frame = viewFrame
        UIView.commitAnimations()
    }
    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let index = self.textFields.index(of: textField) {
            if index < self.textFields.count - 1 {
                let nextField = self.textFields[index + 1]
                nextField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder();
            }
        }
        return true;
    }
}

