//
//  NewsCollectionViewController.swift
//  QuickNews
//
//  Created by Sarannya on 13/05/19.
//  Copyright © 2019 Sarannya. All rights reserved.
//

import UIKit


class NewsCollectionViewController: UICollectionViewController {
    
    let dataSource = NewsDataSource()
    var selectedStoryURL : URL?
    var pageNumber : Int = 1
    
    lazy var viewModel : NewsListViewModel = {
        let viewModel = NewsListViewModel(dataSource: dataSource)
        return viewModel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    
        collectionView.dataSource = self.dataSource
        collectionView.delegate = self
        
        self.dataSource.data.addAndNotify(observer: self) {[weak self] _ in
            self?.collectionView.reloadData()
        }
        self.viewModel.fetchData(fromPage: 1)
        
        if let reachability = Reachability(), !reachability.isReachable{            
            present(SupportViews.CreatNetworkAlert(), animated: true, completion: nil)
        }
    }
}





