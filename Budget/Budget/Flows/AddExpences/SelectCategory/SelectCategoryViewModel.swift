//
//  SelectCategoryViewModel.swift
//  Budget
//
//  Created by Pro2005 on 1/31/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import Foundation
import Domain
import Result
import ReactiveSwift

protocol SelectCategoryViewModelDelegate: class {
    func selectCategoryViewModelWantAddCategory(_ viewModel: SelectCategoryViewController.ViewModel)
}

extension SelectCategoryViewController {
    class ViewModel: ViewModelType {
        weak var delegate: SelectCategoryViewModelDelegate?
        private(set) var dataSource: [CategoryViewModelTypeable] = []
        private let useCase: Domain.CategoryUseCase
        lazy var update = Action<Void, [Domain.Category], AnyError>.init(execute: {[weak self]  in
            guard let `self` = self else {
                return .never
            }
            return self.useCase.fetchAll().flatMap(.latest, { categories in
                return self.updateDataSource(with: categories)
            })
        })
        init(_ useCaseProvider: Domain.CategoryUseCaseProvider) {
            useCase = useCaseProvider.categoryUseCase
        }
        
        // MARK: Public
        
        func select(_ item: CategoryViewModelTypeable) {
            if item.type == .addNew {
                delegate?.selectCategoryViewModelWantAddCategory(self)
            }
        }
        
        // MARK: Private
        
        private func updateDataSource(with categories: [Domain.Category]) -> SignalProducer<[Domain.Category], NoError> {
            return SignalProducer<[Domain.Category], NoError> {[weak self] observer, _ in
                guard let `self` = self else {
                    return
                }
                self.dataSource.removeAll()
                let cellViewModels = categories
                    .map {CategoryCell.CellViewModel(name: $0.name)} as [CategoryViewModelTypeable]
                let addCellViewModel = AddCategoryCell.CellViewModel() as CategoryViewModelTypeable
                self.dataSource.append(contentsOf: cellViewModels + [addCellViewModel])
                observer.send(value: categories)
                observer.sendCompleted()
            }
        }
        
    }
}
