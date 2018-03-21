//
//  DefaultLoadingView.swift
//

import IBAnimatable

class DefaultLoadingView: UIView {

    @IBOutlet weak var activityIndicatorView: AnimatableActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicatorView.animationType = .ballSpinFadeLoader
        activityIndicatorView.color = AppColor.secondaryColor.value
        activityIndicatorView.startAnimating()
    }
}
