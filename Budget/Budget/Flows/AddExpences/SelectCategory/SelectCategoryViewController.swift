//
//  SelectCategoryViewController.swift
//  Budget
//
//  Created by Pro2005 on 1/31/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import UIKit

class SelectCategoryViewController: ViewController {
    var viewModel: SelectCategoryViewModel!
    @IBOutlet private weak var collectionView: UICollectionView!

}

extension SelectCategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}

extension SelectCategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ view: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let items: CGFloat = 3
        let itemSpacing = collectionView(view, layout: layout, minimumInteritemSpacingForSectionAt: indexPath.section)
        let totalSpacing = (items - 1) * itemSpacing
        let length = ((view.bounds.width - totalSpacing) / items).rounded(.down)
        return CGSize(width: length, height: length)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int)
        -> CGFloat
    {
        return 4.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int)
        -> CGFloat
    {
        return 4.0
    }


    
}
