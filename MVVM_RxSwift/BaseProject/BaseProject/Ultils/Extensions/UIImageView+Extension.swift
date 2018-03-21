//
//  UIImageView+Extension.swift
//  AB Branded App
//
//  Created by Lucio Pham on 1/30/18.
//  Copyright © 2018 Lucio Pham. All rights reserved.
//

import Foundation

extension UIImageView {
    
    public func setImage(urlString: String, placeholderImage: UIImage? = nil, completionHandle: CompletionHandler? = nil) {
        
        if let url = URL(string: urlString) {
            kf.setImage(with: url, placeholder: placeholderImage, options: [], completionHandler: completionHandle)
        } else if let urlStringEncode = urlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: urlStringEncode) {
                kf.setImage(with: url,placeholder: placeholderImage, completionHandler: completionHandle)
            }
        }
    }
    
    public func setImageWithFade(urlString: String, placeholderImage: UIImage? = nil) {
        
        if let url = URL(string: urlString) {
            kf.setImage(with: url, placeholder: placeholderImage, options: [.transition(.fade(0.2))])
        } else if let urlStringEncode = urlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: urlStringEncode) {
                kf.setImage(with: url, placeholder: placeholderImage, options: [.transition(.fade(0.2))])
            }
        }
    }
    
    func addMaskView()
    {
        let maskView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 10))
        maskView.backgroundColor = UIColor.black
        maskView.alpha = 0.2
        self.addSubview(maskView)
        maskView.translatesAutoresizingMaskIntoConstraints = false
        let top = NSLayoutConstraint.init(item: maskView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint.init(item: maskView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint.init(item: maskView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint.init(item: maskView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        self.addConstraints([top, bottom, leading, trailing])
    }
}
