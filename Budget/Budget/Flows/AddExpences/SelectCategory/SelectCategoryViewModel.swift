//
//  SelectCategoryViewModel.swift
//  Budget
//
//  Created by Pro2005 on 1/31/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import Foundation

struct SelectCategoryViewModel {
    private(set) var dataSource: [CategoryViewModelTypeable] = []
    
    init() {
        let item1 = AddCategoryCell.CellViewModel()
        dataSource.append(item1)
    }
    
    // MARK: Public
    
    func select(_ item: CategoryViewModelTypeable) {
        
    }
    
}
