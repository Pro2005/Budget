//
//  AddCategoryViewModel.swift
//  Budget
//
//  Created by Pro2005 on 2/3/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa

protocol AddCategoryViewModelDelegate: class {
    func viewModelWantClose(_ viewModel: AddCategoryViewController.ViewModel)
}

extension AddCategoryViewController {
    
    struct ViewModel {
        weak var delegate: AddCategoryViewModelDelegate?
        let name = MutableProperty<String>("")
        
        // MARK: Public
        
        func close() {
            delegate?.viewModelWantClose(self)
        }
        
    }
    
}
