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
    
    struct ViewModel: ViewModelType {
        weak var delegate: AddCategoryViewModelDelegate?
        let name = MutableProperty<String>("")
        lazy var save = Action<Void, Void, AnyError> {[validate] in
            return validate().then
        }
        
        // MARK: Public
        
        func close() {
            delegate?.viewModelWantClose(self)
        }
        
        func validate() -> SignalProducer<Void, AnyError> {
            return SignalProducer {[name] observer, lifetime in
                lifetime.observeEnded {
                    
                }
                guard name.value.count > 0 else {
                    let error = NSError(domain: "", code: 1011, userInfo: nil)
                    observer.send(error: .init(error))
                    return
                }
                observer.send(value: ())
                observer.sendCompleted()
            }
        }
    }
}
