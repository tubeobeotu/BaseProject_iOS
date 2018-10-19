
import UIKit
import ESPullToRefresh
class BasePullToRefreshTableViewController: BaseViewController {
    @IBOutlet weak var tableView: BaseTableView!
    let header = ESRefreshHeaderAnimator.init(frame: CGRect.zero)
    let footer = ESRefreshFooterAnimator.init(frame: CGRect.zero)
    var pullToRefreshEnabled = true{
        didSet{
            if(self.pullToRefreshEnabled == false){
                self.tableView.es.removeRefreshHeader()
            }else{
                self.addRefreshTableView()
            }
        }
    }
    var loadMoreEnabled = true{
        didSet{
            if(self.loadMoreEnabled == false){
                self.tableView.es.removeRefreshFooter()
            }else{
                self.addLoadMoreTableView()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    private func addLoadMoreTableView(){
        self.tableView.es.addInfiniteScrolling(animator: footer) { [weak self] in
            self?.loadMore()
        }
    }
    private func addRefreshTableView(){
        self.tableView.es.addPullToRefresh(animator: header) { [weak self] in
            self?.refresh()
        }
    }
    func refresh() {
        fatalError("[\(#function))] Must be overridden in subclass")
    }
    
    func loadMore() {
        fatalError("[\(#function))] Must be overridden in subclass")
    }
    
    func stopPullToRefresh(){
        self.tableView.es.stopPullToRefresh()
    }
    func stopLoadMoreAnimation(){
        self.tableView.es.stopLoadingMore()
    }
    func showNoMoreData(){
        self.tableView.es.noticeNoMoreData()
    }


}

