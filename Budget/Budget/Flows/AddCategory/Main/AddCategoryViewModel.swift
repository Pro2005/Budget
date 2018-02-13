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
import Domain

protocol AddCategoryViewModelDelegate: class {
    func viewModelWantClose(_ viewModel: AddCategoryViewController.ViewModel)
}

extension AddCategoryViewController {
    
    struct ViewModel: ViewModelType {
        weak var delegate: AddCategoryViewModelDelegate?
        let name = MutableProperty<String>("")
        var save: Action<Void, Void, NoError>
        private let categoryUseCase: Domain.CategoryUseCase
        
        init(useCaseProvider: Domain.UseCaseProvider) {
            categoryUseCase = useCaseProvider.categoryUseCase
            save = Action(execute: {[weak name = name, useCase = categoryUseCase] in
                return SignalProducer { signal, _ in
                    guard let name = name, name.value.count > 0 else {
                        signal.sendInterrupted()
                        return
                    }
                    useCase.add(name.value)
                    signal.sendCompleted()
                }
            })
        }
        
        // MARK: Public
        
        func close() {
            delegate?.viewModelWantClose(self)
        }
        
    }
}
