import Foundation
import UIKit
extension UITableView {
    func enableFullSeperatorTableView()
    {
        self.tableFooterView = UIView.init(frame: CGRect.zero)
        self.separatorInset = .zero
        self.preservesSuperviewLayoutMargins = false
        self.layoutMargins = .zero
    }
}
