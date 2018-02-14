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
    
    class ViewModel: ViewModelType {
        weak var delegate: AddCategoryViewModelDelegate?
        let name = MutableProperty<String>("")
        var save: Action<Void, Void, AnyError>
        private let categoryUseCase: Domain.CategoryUseCase
        
        init(_ useCaseProvider: Domain.CategoryUseCaseProvider) {
            categoryUseCase = useCaseProvider.categoryUseCase
            save = Action(execute: {[weak name = name, useCase = categoryUseCase] in
                return SignalProducer<Void, AnyError> { observer, _  in
                    guard let name = name, name.value.count > 0 else {
                        observer.sendInterrupted()
                        return
                    }
                    useCase.add(name.value).start(observer)
                }
            })
        }
        
        // MARK: Public
        
        func close() {
            delegate?.viewModelWantClose(self)
        }
        
    }
}
