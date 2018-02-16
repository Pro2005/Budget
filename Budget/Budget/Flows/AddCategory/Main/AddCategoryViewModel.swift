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
    func addCategoryViewModelDidSave(_ viewModel: AddCategoryViewController.ViewModel)
    func addCategoryViewModelWantClose(_ viewModel: AddCategoryViewController.ViewModel)
}

extension AddCategoryViewController {
    
    class ViewModel: ViewModelType {
        weak var delegate: AddCategoryViewModelDelegate?
        let name = MutableProperty<String>("")
        private(set) lazy var save: Action<Void, Void, AnyError> = {
            return Action(execute: {[weak self] in
                return SignalProducer<Void, AnyError> { observer, lifetime  in
                    guard let name = self?.name, name.value.count > 0 else {
                        observer.sendInterrupted()
                        return
                    }
                    self?.categoryUseCase.add(name.value).take(during: lifetime).start(observer)
                }
            })
        }() 
        private let categoryUseCase: Domain.CategoryUseCase

        init(_ useCaseProvider: Domain.CategoryUseCaseProvider) {
            categoryUseCase = useCaseProvider.categoryUseCase
            save.completed.observeValues {[unowned self] in
                self.delegate?.addCategoryViewModelDidSave(self)
            }
        }
        
        // MARK: Public
        
        func close() {
            delegate?.addCategoryViewModelWantClose(self)
        }
        
    }
}
