//
//  FSPagerViewCell.swift
//  FSPagerView
//
//  Created by Wenchao Ding on 17/12/2016.
//  Copyright © 2016 Wenchao Ding. All rights reserved.
//

import UIKit
import WebKit
@objc
open class FSPagerViewCell: UICollectionViewCell, WKNavigationDelegate {
    /// Returns the label used for the main textual content of the pager view cell.
    var isLoaded = false
    @objc
    open var textLabel: UILabel? {
        if let _ = _textLabel {
            return _textLabel
        }
        let view = UIView(frame: .zero)
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        let textLabel = UILabel(frame: .zero)
        textLabel.textColor = .white
        textLabel.font = UIFont.preferredFont(forTextStyle: .body)
        textLabel.center = self.center
        self.contentView.addSubview(view)
        view.addSubview(textLabel)
        
        textLabel.addObserver(self, forKeyPath: "font", options: [.old,.new], context: kvoContext)
        
        _textLabel = textLabel
        return textLabel
    }
    
    /// Returns the image view of the pager view cell. Default is nil.
    @objc
    open var imageView: UIImageView? {
        if let _ = _imageView {
            return _imageView
        }
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleToFill
        self.contentView.addSubview(imageView)
        _imageView = imageView
        return imageView
    }
    @objc
    open var webView: WKWebView
    {
        if let _ = _webView {
            isLoaded = true
            return _webView!
        }
        let webView = WKWebView(frame: self.frame)
        webView.navigationDelegate = self
        self.contentView.addSubview(webView)
        _webView = webView
        return webView
    }
    
    fileprivate weak var _textLabel: UILabel?
    fileprivate weak var _imageView: UIImageView?
    fileprivate weak var _webView: WKWebView?
    fileprivate let kvoContext = UnsafeMutableRawPointer(bitPattern: 0)
    fileprivate let selectionColor = UIColor(white: 0.2, alpha: 0.2)
    
    fileprivate weak var _selectedForegroundView: UIView?
    fileprivate var selectedForegroundView: UIView? {
        guard _selectedForegroundView == nil else {
            return _selectedForegroundView
        }
        guard let imageView = _imageView else {
            return nil
        }
        let view = UIView(frame: imageView.bounds)
        imageView.addSubview(view)
        _selectedForegroundView = view
        return view
    }
    
    open override var isHighlighted: Bool {
        set {
            super.isHighlighted = newValue
            if newValue {
                self.selectedForegroundView?.layer.backgroundColor = self.selectionColor.cgColor
            } else if !super.isSelected {
                self.selectedForegroundView?.layer.backgroundColor = UIColor.clear.cgColor
            }
        }
        get {
            return super.isHighlighted
        }
    }
    
    open override var isSelected: Bool {
        set {
            super.isSelected = newValue
            self.selectedForegroundView?.layer.backgroundColor = newValue ? self.selectionColor.cgColor : UIColor.clear.cgColor
        }
        get {
            return super.isSelected
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
//        self.contentView.layer.shadowColor = UIColor.black.cgColor
//        self.contentView.layer.shadowRadius = 5
//        self.contentView.layer.shadowOpacity = 0.75
//        self.contentView.layer.shadowOffset = .zero
    }
    
    deinit {
        if let textLabel = _textLabel {
            textLabel.removeObserver(self, forKeyPath: "font", context: kvoContext)
        }
    }
    @objc
    open func loadRequest(requestURL: String)
    {
        if(isLoaded == true)
        {
            return
        }
        else if let url = URL.init(string: requestURL)
        {
            let request = URLRequest.init(url: url)
            webView.isUserInteractionEnabled = false
            webView.contentMode = .scaleAspectFit
            webView.load(request)
        }
        
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
        if let imageView = _imageView {
            imageView.frame = self.contentView.bounds
        }
        if let webView = _webView {
            webView.frame = self.contentView.bounds
        }
        if let textLabel = _textLabel {
            textLabel.superview!.frame = {
                var rect = self.contentView.bounds
                let height = textLabel.font.pointSize*1.5
                rect.size.height = height
                rect.origin.y = self.contentView.frame.height-height
                return rect
            }()
            textLabel.frame = {
                var rect = textLabel.superview!.bounds
                rect = rect.insetBy(dx: 8, dy: 0)
                rect.size.height -= 1
                rect.origin.y += 1
                return rect
            }()
        }
        if let selectedForegroundView = _selectedForegroundView {
            selectedForegroundView.frame = self.contentView.bounds
        }
    }

    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == kvoContext {
            if keyPath == "font" {
                self.setNeedsLayout()
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    //WebViewDelegate
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.showNetworkIndicator(enable: false)
        print(error.localizedDescription)
    }
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showNetworkIndicator(enable: true)
        print("Strat to load")
    }
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.showNetworkIndicator(enable: false)
        print("finish to load")
    }
    
    func showNetworkIndicator(enable: Bool)
    {
         UIApplication.shared.isNetworkActivityIndicatorVisible = enable
    }
}