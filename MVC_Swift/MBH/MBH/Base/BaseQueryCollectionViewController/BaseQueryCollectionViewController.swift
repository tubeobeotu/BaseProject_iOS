//
//  BaseQueryCollectionViewController.swift
//

import UIKit

class BaseQueryCollectionViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var pullToRefreshEnabled = true
    lazy var loadMoreEnabled = true
    lazy var allObjects = [Any]()
    
    var contentState: ContentState = .hasContent {
        didSet {
            loadingView.isHidden = true
            emptyView.isHidden = true
            errorView.isHidden = true
            
            switch contentState {
            case .hasContent:
                collectionView.reloadData()
                break
            case .loading:
                loadingView.isHidden = false
                break
            case .empty:
                emptyView.isHidden = false
                break
            case .error:
                errorView.isHidden = false
                break
            case .done:
                loadingView.isHidden = true
                break
            }
        }
    }
    
    lazy var loadingView: UIView = {
        let loadingView = DefaultLoadingView.loadFromNib()
        loadingView.frame = self.collectionView.bounds
        self.collectionView.addSubview(loadingView)
        return loadingView
    }()
    
    lazy var emptyView: UIView = {
        let emptyView = DefaultEmptyView.loadFromNib()
        emptyView.frame = self.collectionView.bounds
        self.collectionView.addSubview(emptyView)
        return emptyView
    }()
    
    lazy var errorView: UIView = {
        let errorView = DefaultErrorView.loadFromNib()
        errorView.frame = self.collectionView.bounds
        self.collectionView.addSubview(errorView)
        return errorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if contentState != .hasContent {
            loadingView.center = collectionView.center
            emptyView.center = collectionView.center
            errorView.center = collectionView.center
        }
    }
}

extension BaseQueryCollectionViewController: UICollectionViewDataSource {
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allObjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension BaseQueryCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
}

extension BaseQueryCollectionViewController: UICollectionViewDelegate {
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
