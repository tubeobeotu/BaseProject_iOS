
import Foundation
import UIKit
//import MarqueeLabel
extension UIViewController {
    // MARK: - Actions
    @objc func callSupportAction() {
        let alertController = UIAlertController(title:  "callSupport".localizedString(), message: "call19001600".localizedString(), preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "CÓ".localizedString(), style: UIAlertActionStyle.default, handler:{(alertAction) in
                if let url = URL(string: "tel://\(1789)"), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }))
        alertController.addAction(UIAlertAction(title: "KHÔNG".localizedString(), style: UIAlertActionStyle.default, handler:nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func viewInfoAction() {
        
    }

}

