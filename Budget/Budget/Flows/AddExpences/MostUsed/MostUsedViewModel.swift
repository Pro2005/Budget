//
//  MostUsedExpensesViewModel.swift
//  Budget
//
//  Created by Illya on 2/16/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import Foundation

protocol MostUsedExpensesViewModelDelegate: class {
    func mostUsedViewModelWantAdd(_ viewModel: MostUsedExpensesViewController.ViewModel)
}

extension MostUsedExpensesViewController {
    
    class ViewModel: ViewModelType {
        weak var delegate: MostUsedExpensesViewModelDelegate?
        private(set) var dataSource: [MostUsedExpensesCell.ViewModel] = []
        
        // MARK: Initialization
        
        init() {
            setup()
        }
        
        // MARK: Public
        
        func add() {
            delegate?.mostUsedViewModelWantAdd(self)
        }
        
        // MARK: Private
        
        private func setup() {
            
        }
        
    }
    
}
