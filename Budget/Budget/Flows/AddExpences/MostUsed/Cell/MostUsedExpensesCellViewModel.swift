//
//  MostUsedExpensesViewModel.swift
//  Budget
//
//  Created by Illya on 2/16/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import Foundation

extension MostUsedExpensesCell {
    
    class ViewModel: ViewModelType {
        let categoryName: String
        let expenseName: String
        let amount: String
        
        init(categoryName: String, expenseName: String, amount: String) {
            self.categoryName = categoryName
            self.expenseName = expenseName
            self.amount = amount
        }
        
    }
    
}
