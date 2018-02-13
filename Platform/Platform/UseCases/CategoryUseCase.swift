//
//  CategoryUseCase.swift
//  Platform
//
//  Created by Illya on 2/13/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import Foundation
import Domain
import ReactiveSwift
import Result

struct CategoryUseCase: Domain.CategoryUseCase {
    
    func add(_ name: String) -> SignalProducer<Void, AnyError> {
        return SignalProducer {signal, lifetime in
            signal.sendCompleted()
        }
    }
    
}
