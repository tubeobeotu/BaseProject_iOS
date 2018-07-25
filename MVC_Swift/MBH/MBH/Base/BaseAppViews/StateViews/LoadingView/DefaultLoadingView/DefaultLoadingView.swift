//
//  DefaultLoadingView.swift
//

//import IBAnimatable
import UIKit
class DefaultLoadingView: BaseCustomNibView {

//    @IBOutlet weak var activityIndicatorView: AnimatableActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.red
//        activityIndicatorView.startAnimating()
    }
}
