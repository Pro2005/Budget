//
//  SelectCategoryViewController.swift
//  Budget
//
//  Created by Pro2005 on 1/31/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import UIKit
import ReactiveSwift

class SelectCategoryViewController: ViewController {
    var viewModel: ViewModel!
    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: Private
    
    private func setup() {
        setupCollectionView()
        bindViewModel()
    }
    
    private func setupCollectionView() {
        collectionView.register(R.nib.addCategoryCell)
        collectionView.register(R.nib.categoryCell)
    }
    
    private func bindViewModel() {
        collectionView.reactive.reloadData <~ viewModel.update.values.map {_ in return ()}
        viewModel.update <~ reactive.trigger(for: #selector(viewDidAppear(_:)))
    }
    
}

extension SelectCategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let ViewModel = viewModel.dataSource[indexPath.row]
        switch ViewModel.type {
        case .addNew:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.addCategoryCell, for: indexPath)!
            cell.viewModel = ViewModel as? AddCategoryCell.ViewModel
            return cell
        case .default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.categoryCell, for: indexPath)!
            cell.viewModel = ViewModel as? CategoryCell.ViewModel
            return cell
        }
    }
    
}

extension SelectCategoryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ViewModel = viewModel.dataSource[indexPath.row]
        viewModel.select(ViewModel)
    }
    
}

extension SelectCategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ view: UICollectionView,
                        layout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let items: CGFloat = 3
        let itemSpacing = collectionView(view, layout: layout, minimumInteritemSpacingForSectionAt: indexPath.section)
        let totalSpacing = (items - 1) * itemSpacing
        let length = ((view.bounds.width - totalSpacing) / items).rounded(.down)
        return CGSize(width: length, height: length)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int)
        -> CGFloat {
        return 4.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int)
        -> CGFloat {
        return 4.0
    }

}
