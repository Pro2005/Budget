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
import Result

protocol AddCategoryViewModelDelegate: class {
    func viewModelWantClose(_ viewModel: AddCategoryViewController.ViewModel)
}

extension AddCategoryViewController {
    
    class ViewModel: ViewModelType {
        weak var delegate: AddCategoryViewModelDelegate?
        let name = MutableProperty<String>("")
        lazy var save = Action<Void, Void, NoError> {[weak self] value in
            print(value)
            return SignalProducer{ signal, lifetime in
                signal.sendCompleted()
            }
        }
        
        // MARK: Public
        
        func close() {
            delegate?.viewModelWantClose(self)
        }
        
    }
    
}
