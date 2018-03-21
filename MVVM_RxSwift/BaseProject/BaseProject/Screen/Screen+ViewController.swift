import Foundation

extension Screen {
    
    func viewController() -> UIViewController {
        
        switch self {
            
        case .payment(let viewModel):
            var paymentVC = ABCardsAndPromotionsVC.instantiateFromXib()
            paymentVC.bindViewModel(to: viewModel)
            let nav = BaseNavigationController(rootViewController: paymentVC)
            return nav
        }
        
    }
}
