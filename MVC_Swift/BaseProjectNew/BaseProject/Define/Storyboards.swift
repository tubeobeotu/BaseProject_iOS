
import Foundation
import UIKit

struct Storyboard {
    
}

extension Storyboard {

    struct cellVuotTarget {
        static let cellVuotTarget = UIStoryboard(name: "CellVuotTarget", bundle: nil)
        
        static func cellVuotTargetNavigationController() -> BaseNavigationController {
            return cellVuotTarget.instantiateViewController(withIdentifier: "CellVuotTargetNavigationController") as! BaseNavigationController
        }
    }
    
    struct canhBaoCell {
        static let canhBaoCell = UIStoryboard(name: "CanhBaoCell", bundle: nil)
        
        static func canhBaoCellNavigationController() -> BaseNavigationController {
            return canhBaoCell.instantiateViewController(withIdentifier: "CanhBaoCellNavigationController") as! BaseNavigationController
        }
    }
}




