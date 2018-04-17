import Foundation
class BaseCustomNibView: UIView
{
    var contentView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    private func nibSetup() {
        backgroundColor = .clear
        
        contentView = loadViewFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(contentView)
        
        setupViews()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    func setupViews()
    {
        
    }
}
