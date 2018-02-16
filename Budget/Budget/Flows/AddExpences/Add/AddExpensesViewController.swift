//
//  AddExpensesViewController.swift
//  Budget
//
//  Created by Illya on 2/16/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import UIKit

class AddExpensesViewController: ViewController {
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var categoryButton: UIButton!
    @IBOutlet private weak var addButton: UIButton!
    
    var viewModel: ViewModel!
    
}

extension AddExpensesViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
