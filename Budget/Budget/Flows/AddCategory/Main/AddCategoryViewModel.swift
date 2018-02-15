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

extension AddCategoryViewController {
    
    class ViewModel: ViewModelType {
        let name = MutableProperty<String>("")
        var save: Action<Void, Void, AnyError>!
        let didSave = Signal<Void, NoError>.pipe()
        let wantClose = Signal<Void, NoError>.pipe()
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
                    }.on (completed: {self?.didSave.input.sendCompleted()})
            })
        }
        
        // MARK: Public
        
        func close() {
            wantClose.input.sendCompleted()
        }
        
    }
}
