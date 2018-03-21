import UIKit

class BaseViewController: UIViewController {
    
    lazy var keyboardRect = Variable<CGRect>(CGRect(x: 0, y: 0, width: 0, height: 0))
    lazy var bottomButton =  ABButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
    var bottomButtonTitle = ""
    var isAddBottomButton = false
    var disableShowLayoutError = false {
        didSet{
            if(disableShowLayoutError == true)
            {
                UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
            }
        }
    }
    var enableTriggerKeyBoard:Bool = false{
        didSet{
            if(enableTriggerKeyBoard)
            {
                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(BaseViewController.keyboardWillShow(_:)),
                    name: NSNotification.Name.UIKeyboardWillShow,
                    object: nil
                )
                
                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(BaseViewController.keyboardWillHide(_:)),
                    name: NSNotification.Name.UIKeyboardWillHide,
                    object: nil
                )
            }
        }
    }
    
    var bag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.setValue(true, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        self.edgesForExtendedLayout = UIRectEdge()
        self.localize()
        self.configureBackBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if(isAddBottomButton == false && bottomButtonTitle != "")
        {
            addBottomButtonAfterLayout(title: bottomButtonTitle)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    func addBottomButton(title: String) {
        bottomButtonTitle = title
    }
    
    func addBottomButtonAfterLayout(title: String)
    {
        isAddBottomButton = true
        bottomButton.setTitle(title, for: .normal)
        //    bottomButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(bottomButton)
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        let height = NSLayoutConstraint.init(item: bottomButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        let bottom = NSLayoutConstraint.init(item: bottomButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -10 - self.getSafeLayout().bottom)
        let leading = NSLayoutConstraint.init(item: bottomButton, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 16)
        let trailing = NSLayoutConstraint.init(item: bottomButton, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -16)
        self.view.addConstraints([height, bottom, leading, trailing])
    }
    
    //  @objc func buttonAction(sender: UIButton!) {
    //    debugPrint("Button tapped")
    //  }
    
    deinit {
        debugPrint("\(self.nameOfClass) View Controller Already Deallocate")
    }
    
    func hideKeyBoard()
    {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            keyboardRect.value = keyboardFrame.cgRectValue
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        keyboardRect.value = CGRect.zero
        self.keyboardWillHide()
    }
    
    func keyboardWillHide()
    {
        
    }
    
    func showErrorWithMoyaError(moyaError: MoyaError)
    {
        switch(moyaError)
        {
        case .underlying(let error, _):
            if let abError = error as? ABError
            {
                self.showAlertViewDefaul(message: abError.message)
            }else
            {
                self.showAlertViewDefaul(message: error.localizedDescription)
            }
            
            break
        default:
            self.showAlertViewDefaul(message: moyaError.errorDescription)
        }
    }
    
    func showErrorWithError(error: Error)
    {
        self.showAlertViewDefaul(message: error.localizedDescription)
    }
    
    func showErrorWithABError(error: ABError)
    {
        self.showAlertViewDefaul(message: error.message)
    }
    
    func checkError(model: Any?, showError:Bool = true) -> ErrorType
    {
        if let currentModel = model
        {
            if let error = currentModel as? ABError
            {
                if(showError == true)
                {
                    self.showErrorWithABError(error: error)
                }
                
                return .ABError
            }
            else if let moyaError = currentModel as? MoyaError
            {
                if(showError == true)
                {
                    self.showErrorWithMoyaError(moyaError: moyaError)
                }
                
                return .Moya
            }
            else if let error = currentModel as? Error
            {
                if(showError == true)
                {
                    self.showErrorWithError(error: error)
                }
                return .Normal
            }
            return .Success
        }
        return .Nil
    }
    
    internal func configureBackBarButton() {
        navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "Back_Icon").withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "Back_Icon").withRenderingMode(.alwaysOriginal)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
}

enum ErrorType: NSInteger
{
    case Nil
    case Success
    case Moya
    case Normal
    case ABError
}
