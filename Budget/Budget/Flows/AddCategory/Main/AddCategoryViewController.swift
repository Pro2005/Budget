//
//  AddCategoryViewController.swift
//  Budget
//
//  Created by Pro2005 on 2/3/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class AddCategoryViewController: ViewController {
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var addButton: UIButton!
    var viewModel: AddCategoryViewController.ViewModel!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    // Actions
    
    @IBAction func closeTap() {
        viewModel.close()
    }
    
    @IBAction func addTap() {
        view.endEditing(true)
    }

    // MARK: Private
    
    private func bindViewModel() {
        textField.reactive.text <~ viewModel.name
    }
    
}

extension AddCategoryViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
