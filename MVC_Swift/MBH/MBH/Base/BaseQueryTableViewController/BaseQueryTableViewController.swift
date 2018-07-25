//
//  BaseQueryTableViewController.swift
//

import UIKit
import PullToRefreshKit
class BaseQueryTableViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    lazy var canConfigLoadMore = true
    lazy var pullToRefreshEnabled = true
    lazy var loadMoreEnabled = true
    lazy var triggered = false
    lazy var isObject = false
    lazy var allObjects = [BaseDataModel]()
    lazy var tmpAllObjects = [BaseDataModel]()
    lazy var object = BaseDataModel()
    lazy var totalObjects = 0
    lazy var numReason = 0
    lazy var allowLoadMore = true
    lazy var page = 0
    lazy var skip = 0
    lazy var limit = 10
    lazy var enableCheckDuplicate = true
    lazy var enableAutoAddEmpty = true
    //Empty label
    var emptyLabel: String = "Không tìm thấy công việc".localizedString()
    var enableShowFullSeperator = false
    {
        didSet {
            if enableShowFullSeperator == true
            {
                self.enableFullSeperatorTableView()
            }
        }
    }
    var contentState: ContentState = .hasContent {
        didSet {
            loadingViewValue?.removeFromSuperview()
            emptyViewValue?.removeFromSuperview()
            errorViewValue?.removeFromSuperview()
            loadingViewValue = nil
            emptyViewValue = nil
            errorViewValue = nil
            let screenSize = UIScreen.main.bounds.size
            switch contentState {
            case .hasContent:
                tableView.reloadData()
                
            case .loading:
                let window = UIApplication.shared.keyWindow
                loadingView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
                window?.addSubview(loadingView)
                
            case .empty:
                if(enableAutoAddEmpty)
                {
                    changeEmptyView().frame = CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height)
                    tableView.addSubview(changeEmptyView())
                }
                
                
            case .error:
                errorView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height)
                tableView.addSubview(errorView)
            case .done:
                break
            }
        }
    }
    
    var loadingViewValue: UIView?
    var loadingView: UIView {
        get {
            if loadingViewValue == nil {
                loadingViewValue = DefaultLoadingView()
            }
            
            return loadingViewValue!
        }
    }
    
    //    var emptyView: DefaultEmptyView {
    //        get {
    //            if emptyViewValue == nil {
    //                emptyViewValue = DefaultEmptyView.loadFromNib()
    //            }
    //            emptyViewValue?.titleLabel.text = emptyLabel
    //            emptyViewValue?.subTitleLabel.text = ""
    //            emptyViewValue?.cloudIconImage.isHidden = true
    //            return emptyViewValue!
    //        }
    //    }
    var emptyViewValue: DefaultEmptyView?
    public func changeEmptyView() -> DefaultEmptyView{
        
        if emptyViewValue == nil {
            emptyViewValue = DefaultEmptyView.loadFromNib()
        }
        emptyViewValue?.titleLabel.text = emptyLabel
        emptyViewValue?.subTitleLabel.text = ""
        emptyViewValue?.cloudIconImage.isHidden = true
        return emptyViewValue!
    }
    
    
    var errorViewValue: UIView?
    var errorView: UIView {
        get {
            if errorViewValue == nil {
                errorViewValue = DefaultErrorView.loadFromNib()
            }
            
            return errorViewValue!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            //            tableView.contentInsetAdjustmentBehavior = .never
        }
        if triggered {
            contentState = .loading
            loadObjects(clear: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Query database
    public func queryForTable() -> BaseRouter? {
        return nil
    }
    
    func loadObjects(clear: Bool = false) {
        tmpAllObjects = allObjects
        if clear {
            allowLoadMore = true
            totalObjects = 0
            numReason = 0
            skip = 0
            page = 0
            allObjects.removeAll()
            tableView.reloadData()
        }
        if let query = queryForTable() {
            
            objectsWillLoad()
//            query.request(completed: { (result) in
//                switch result {
//                case .success(let response, let otherResponse):
//                    if let total = otherResponse as? Int {
//                        self.totalObjects = total
//                    }
//                    if let numReason = otherResponse as? Int {
//                        self.numReason = numReason
//                    }
//
//                    if let allObjects = response as? [BaseDataModel] {
//                        for object in allObjects {
//                            //  if !self.allObjects.contains(where: { self.enableCheckDuplicate && $0.objectId == object.objectId }) {
//                            self.allObjects.append(object)
//                            //  }
//                            //self.allObjects.append(object)
//                        }
//
//
//                        if self.allObjects.count > 0 {
//                            if allObjects.count > 0 {
//                                self.skip = (self.page + 1) * self.limit
//                                self.page += 1
//                                self.contentState = .hasContent
//                            } else {
//                                self.objectsDidLoad(error: true)
//                            }
//
//                            if self.allObjects.count % self.limit != 0 || allObjects.count.isZero() || self.allObjects.count == self.totalObjects{
//                                self.allowLoadMore = false
//                                self.tableView.setFooterNoMoreData()
//                                self.tableView.endFooterRefreshingWithNoMoreData()
//                            }
//                        }
//                        if self.allObjects.count < self.limit
//                        {
//                            self.allowLoadMore = false
//                        }
//                        self.objectsDidLoad()
//                    } else if let object = response as? BaseDataModel {
//                        self.tableView.endHeaderRefreshing()
//                        self.isObject = true
//                        self.object = object
//                        self.allObjects.append(object)
//                        self.contentState = .hasContent
//                        self.objectsDidLoad(error: false)
//                        if self.limit == 1 {
//                            self.allowLoadMore = false
//                            self.tableView.setFooterNoMoreData()
//                            self.tableView.endFooterRefreshingWithNoMoreData()
//                        }
//                    } else {
//                        self.objectsDidLoad(error: true)
//                    }
//                    self.objectsDidLoad(rawResponse: response)
//
//                case .networkError():
//                    self.allObjects = self.tmpAllObjects
//                    self.contentState = .hasContent
//                    break
//                default:
//                    if self.allObjects.count.isZero() {
//                        self.contentState = .error
//                    } else {
//                        self.contentState = .hasContent
//                    }
//
//                    self.objectsDidLoad(error: true)
//                    self.objectsDidLoad(rawResponse: result)
//                }
//
//                if self.contentState == .loading, self.allObjects.count.isZero() {
//                    self.contentState = .empty
//                }
//                //End refresh on TableView:
//                self.tableView.endHeaderRefreshing()
//                self.tableView.endFooterRefreshing()
//            })
        }
    }
    
    func objectsWillLoad() {
        
    }
    
    func objectsDidLoad(error: Bool = false) {
        
    }
    
    func objectsDidLoad(rawResponse: Any?)
    {
        
    }
    override func configuration() {
        isLoadConfig = true
        if queryForTable() != nil {
            // Setup the pull to refresh
            if pullToRefreshEnabled {
                tableView.setUpHeaderRefresh {
                    self.allowLoadMore = true
                    self.loadObjects(clear: true)
                    }.SetUp({ (header) in
                        header.setText("Kéo để làm mới".localizedString(), mode: .pullToRefresh)
                        header.setText("Thả ra để làm mới".localizedString(), mode: .releaseToRefresh)
                        header.setText("Đang tải...".localizedString(), mode: .refreshing)
                        header.textLabel.textColor = Constant.color.blueVSmart
                        header.textLabel.font = Constant.font.robotoRegular(ofSize: 15)
                        header.imageView.image = nil
                    })
            }
            
            // Setup the load more
            if loadMoreEnabled {
                tableView.setUpFooterRefresh {
                    if self.allowLoadMore {
                        self.loadObjects()
                    } else {
                        self.tableView.endFooterRefreshing()
                        self.tableView.setFooterNoMoreData()
                        self.tableView.endFooterRefreshingWithNoMoreData()
                    }
                    }.SetUp({ (footer) in
                        footer.setText("", mode: .pullToRefresh)
                        footer.setText("", mode: .tapToRefresh)
                        footer.setText("", mode: .scrollAndTapToRefresh)
                        footer.setText("Đang tải...".localizedString(), mode: .refreshing)
                        footer.setText("", mode: .noMoreData)
                        footer.textLabel.textColor = Constant.color.blueVSmart
                        footer.textLabel.font = Constant.font.robotoRegular(ofSize: 15)
                    })
            }
        }
    }
    override func reloadData() {
        super.reloadData()
        contentState = .loading
        loadObjects(clear: true)
    }
}

extension BaseQueryTableViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isObject {
            return 1
        }
        
        return allObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

extension BaseQueryTableViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension BaseQueryTableViewController {
    func enableFullSeperatorTableView()
    {
        self.tableView.enableFullSeperatorTableView()
    }
}

