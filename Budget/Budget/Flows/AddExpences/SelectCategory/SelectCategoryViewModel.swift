//
//  SelectCategoryViewModel.swift
//  Budget
//
//  Created by Pro2005 on 1/31/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import Foundation
import Domain

protocol SelectCategoryViewModelDelegate: class {
    func selectCategoryViewModelWantAddCategory(_ viewModel: SelectCategoryViewController.ViewModel)
}

extension SelectCategoryViewController {
    class ViewModel: ViewModelType {
        weak var delegate: SelectCategoryViewModelDelegate?
        private(set) var dataSource: [CategoryViewModelTypeable] = []
        private let useCase: Domain.CategoryUseCase
        
        init(_ useCaseProvider: Domain.CategoryUseCaseProvider) {
            useCase = useCaseProvider.categoryUseCase
            update()
    //        let item1 = AddCategoryCell.CellViewModel()
    //        dataSource.append(item1)
        }
        
        // MARK: Public
        
        func select(_ item: CategoryViewModelTypeable) {
            if item.type == .addNew {
                delegate?.selectCategoryViewModelWantAddCategory(self)
            }
        }
        
        // MARK: Private
        
        private func update() {
            let disposable = useCase.fetchAll().on(value: {[weak self] categories in
                self?.updateDataSource(with: categories)
            }).start()

        }
        
        private func updateDataSource(with categories: [Domain.Category]) {
            let cellViewModels = categories
                .map {CategoryCell.CellViewModel(name: $0.name)} as [CategoryViewModelTypeable]
            let addCellViewModel = AddCategoryCell.CellViewModel() as CategoryViewModelTypeable
            dataSource.append(contentsOf: cellViewModels + [addCellViewModel])
        }
        
    }
}
