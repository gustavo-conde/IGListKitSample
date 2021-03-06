//
//  ViewController.swift
//  OLX Feed Sample
//
//  Created by Gustavo Conde on 10/5/17.
//  Copyright © 2017 Gustavo Conde. All rights reserved.
//

import UIKit
import IGListKit
import Alamofire
import AlamofireObjectMapper
import SVProgressHUD

final class SearchViewController: UIViewController {
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    var filterString = ""
    var posts = [Post]()
    var refresher: UIRefreshControl!
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let searchToken: NSNumber = 42
    let endpoint = "https://api-v2.olx.com/items?location=www.olx.com.ar&searchTerm=auto"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        title = "OLX Search"
        
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        refresher = UIRefreshControl()
        collectionView.alwaysBounceVertical = true
        refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        collectionView.addSubview(refresher)

        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    @objc func loadData() {
        refresher.endRefreshing()
        SVProgressHUD.show()
        Alamofire.request(endpoint).responseObject() { (response: DataResponse<Posts>) in
            SVProgressHUD.dismiss()
            if let posts = response.result.value {
                self.posts = posts.posts
                self.adapter.performUpdates(animated: true, completion: nil)
            }
        }
    }
}
    
// MARK: ListAdapterDataSource
extension SearchViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        guard filterString != "" else { return [searchToken] + posts as [ListDiffable] }
        return [searchToken] + posts.filter { $0.title.lowercased().contains(filterString.lowercased()) }.map { $0 as ListDiffable }
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if let obj = object as? NSNumber, obj == searchToken {
            let sectionController = SearchSectionController()
            sectionController.delegate = self
            return sectionController
        } else {
            let configureBlock = { (item: Any, cell: UICollectionViewCell) in
                guard let cell = cell as? PostViewCell, let post = item as? Post else { return }
                cell.config(with: post)
            }
            
            let sizeBlock = { (item: Any, context: ListCollectionContext?) -> CGSize in
                guard let context = context else { return CGSize() }
                return CGSize(width: context.containerSize.width, height: 337)
            }
            let sectionController = ListSingleSectionController(nibName: PostViewCell.nibName,
                                                                bundle: nil,
                                                                configureBlock: configureBlock,
                                                                sizeBlock: sizeBlock)
            
            return sectionController
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
    
// MARK: SearchSectionControllerDelegate
extension SearchViewController: SearchSectionControllerDelegate {
    
    func searchSectionController(_ sectionController: SearchSectionController, didChangeText text: String) {
        filterString = text
        adapter.performUpdates(animated: true, completion: nil)
    }
    
}


