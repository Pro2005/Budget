//
//  CategoryCellViewModel.swift
//  Budget
//
//  Created by Pro2005 on 2/3/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import Foundation

enum CategoryType {
    case `default`
    case addNew
}

protocol CategoryViewModelTypeable {
    var type: CategoryType { get }
}

extension CategoryCell {
    
    struct CellViewModel: CategoryViewModelTypeable {
        let type: CategoryType = .default
        let name: String
    }
    
}
