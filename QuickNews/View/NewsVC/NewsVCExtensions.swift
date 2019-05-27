//
//  NewsVCExtensions.swift
//  QuickNews
//
//  Created by Sarannya on 17/05/19.
//  Copyright © 2019 Sarannya. All rights reserved.
//

import UIKit

//MARK:- Handle didSelectItemAt indexPath
extension NewsCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let url =  dataSource.data.value[indexPath.row].newsUrl() else {
            return
        }
        selectedStoryURL = url
        
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let storyVC = mainStoryBoard.instantiateViewController(withIdentifier: "StoryViewController") as! StoryViewController
        
        storyVC.storyURL = selectedStoryURL
        
        self.navigationController?.pushViewController(storyVC, animated: true)
    }
    
}


//MARK:- UICollectionViewDelegateFlowLayout - Handle column count

/***  Reference for cell resizing
 1.  https://developer.apple.com/documentation/uikit/uicollectionviewdelegateflowlayout/1617708-collectionview
 2. https://stackoverflow.com/questions/14674986/uicollectionview-set-number-of-columns ***/

extension NewsCollectionViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize{
        //default cells
        var noOfColums = 2
        let orientation = UIDevice.current.orientation
        
        if  orientation == UIDeviceOrientation.landscapeLeft ||
            orientation == UIDeviceOrientation.landscapeRight
        {
            //no: of cells in landscape
            noOfColums = 3
        }
        
        if (indexPath.row % 7) == 0
        {
            // every 1st element in a set of 7 stories
            noOfColums = 1
        }
        
        return configuredCellSize(for : indexPath.row, with : noOfColums, and : orientation)
    }
    
    

    
    func configuredCellSize(for index : Int, with noOfColums : Int, and orientation : UIDeviceOrientation) -> CGSize{
        
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalWidth = flowLayout.sectionInset.left + flowLayout.sectionInset.right +         (flowLayout.minimumInteritemSpacing * CGFloat(noOfColums - 1))
        
        let cellSize = Int((collectionView.bounds.width -  totalWidth) / CGFloat(noOfColums))
        
        if (noOfColums == 1){
            if ((orientation == UIDeviceOrientation.landscapeLeft || orientation == UIDeviceOrientation.landscapeRight)){
                return CGSize(width: cellSize, height: 275)
            }
            
            return CGSize(width: cellSize, height: 180)
        }
        
        return CGSize(width: cellSize, height: cellSize)
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout();
        collectionView.reloadData()        
    }
    
    
    
    
//MARK:- Load more data & reload the collection view

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == dataSource.data.value.count - 1) { //it's your last cell
            
            if (TotalArticleList.shared.totalItems! > (TotalArticleList.shared.loadedArticleList?.count)!)
            {
                pageNumber += 1
                self.viewModel.fetchData(fromPage: pageNumber)
            }

        }
    }
}




