import UIKit

class LoadingView: UIView {

    @IBOutlet weak var loadingImageView: UIImageView!
    @IBOutlet weak var loadingTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.loadingTitleLabel.text = VTLocalizedString.localized(key: "loggingIn")
    }
    
    func startRotate() {
        loadingImageView.startRotating(duration: 1.0)
    }
}
