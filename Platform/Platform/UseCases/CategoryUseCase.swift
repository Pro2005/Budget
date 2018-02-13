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
        return CoreDataStack.shared().flatMap(.concat, { (stack: CoreDataStack) in
            return SignalProducer<Void, AnyError> { observer, lifetime in
                
                
                
                observer.send(value: ())
                observer.sendCompleted()
            }
        })
    }
    
}
