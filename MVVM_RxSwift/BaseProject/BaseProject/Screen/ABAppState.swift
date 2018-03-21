import Foundation
class ABAppState
{
    enum State: NSInteger
    {
        case Loading
        case Finish
    }
    var state:State = .Finish
    {
        didSet{
            numberOfLoadingViews = numberOfLoadingViews < 0 ? 0 : numberOfLoadingViews
            switch(state)
            {
            case .Loading:
                numberOfLoadingViews = numberOfLoadingViews + 1
                if(numberOfLoadingViews == 1)
                {
                    self.addLoadingView()
                }
            case .Finish:
                numberOfLoadingViews = numberOfLoadingViews - 1
                if(numberOfLoadingViews == 0)
                {
                    self.removeLoadingView()
                }
            }
        }
    }
    static let sharedInstance = ABAppState()
    var numberOfLoadingViews = 0
    var loadingViewValue: UIView?
    var loadingView: UIView {
        get {
            if loadingViewValue == nil {
                loadingViewValue = DefaultLoadingView.instantiateFromXib()
            }
            
            return loadingViewValue!
        }
    }
    
    
    private func removeLoadingView()
    {
        loadingViewValue?.removeFromSuperview()
        loadingViewValue = nil
    }
    private func addLoadingView()
    {
        self.removeLoadingView()
        let screenSize = UIScreen.main.bounds.size
        let window = UIApplication.shared.keyWindow
        loadingView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        window?.addSubview(loadingView)
        
        
    }
}
