//
//  DefaultLoadingView.swift
//

//import IBAnimatable
import UIKit
class DefaultLoadingView: UIView {
    @IBOutlet weak var loadingView: UIView!
    
//    @IBOutlet weak var activityIndicatorView: AnimatableActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        activityIndicatorView.startAnimating()
    }
}
