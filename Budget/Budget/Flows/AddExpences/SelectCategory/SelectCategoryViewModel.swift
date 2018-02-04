//
//  SelectCategoryViewModel.swift
//  Budget
//
//  Created by Pro2005 on 1/31/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import Foundation

protocol SelectCategoryViewModelDelegate: class {
    func selectCategoryViewModelWantAddCategory(_ viewModel: SelectCategoryViewModel)
}

struct SelectCategoryViewModel {
    weak var delegate: SelectCategoryViewModelDelegate?
    private(set) var dataSource: [CategoryViewModelTypeable] = []
    
    init() {
        let item1 = AddCategoryCell.CellViewModel()
        dataSource.append(item1)
    }
    
    // MARK: Public
    
    func select(_ item: CategoryViewModelTypeable) {
        if item.type == .addNew {
            delegate?.selectCategoryViewModelWantAddCategory(self)
        }
    }
    
}
