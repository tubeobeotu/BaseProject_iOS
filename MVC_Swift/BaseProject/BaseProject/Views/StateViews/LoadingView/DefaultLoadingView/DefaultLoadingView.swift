//
//  DefaultLoadingView.swift
//

import IBAnimatable

class DefaultLoadingView: UIView {

    @IBOutlet weak var activityIndicatorView: AnimatableActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicatorView.startAnimating()
    }
}
