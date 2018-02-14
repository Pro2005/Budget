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
    func addCategoryViewModelWantClose(_ viewModel: AddCategoryViewController.ViewModel)
    func addCategoryViewModelDidAddCategory(_ viewModel: AddCategoryViewController.ViewModel)
}

extension AddCategoryViewController {
    
    class ViewModel: ViewModelType {
        weak var delegate: AddCategoryViewModelDelegate?
        let name = MutableProperty<String>("")
        var save: Action<Void, Void, AnyError>!
        private let categoryUseCase: Domain.CategoryUseCase
        
        init(_ useCaseProvider: Domain.CategoryUseCaseProvider) {
            categoryUseCase = useCaseProvider.categoryUseCase
            save = Action(execute: {[weak self] in
                return SignalProducer<Void, AnyError> { observer, _  in
                    guard let name = self?.name, name.value.count > 0 else {
                        observer.sendInterrupted()
                        return
                    }
                    self?.categoryUseCase.add(name.value).start(observer)
                }.on(completed: {
                    guard let `self` = self else {
                        return
                    }
                    self.delegate?.addCategoryViewModelDidAddCategory(self)
                })
            })
        }
        
        // MARK: Public
        
        func close() {
            delegate?.addCategoryViewModelWantClose(self)
        }
        
    }
}
