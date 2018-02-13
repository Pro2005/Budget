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
import CoreData

struct CategoryUseCase: Domain.CategoryUseCase {
    
    func fetchAll() -> SignalProducer<[Domain.Category], AnyError> {
        return CoreDataStack.shared().flatMap(.concat, { (stack: CoreDataStack) in
            return stack.fetchAll(typeEntity: CategoryEntity.self).map({ (entities) -> [Domain.Category] in
                return entities.mapToDomain()
            })
        })
    }
    
    func add(_ name: String) -> SignalProducer<Void, AnyError> {
        return CoreDataStack.shared().flatMap(.concat, { (stack: CoreDataStack) in
            return stack.save(block: { (context: NSManagedObjectContext) in
                let newCategory: CategoryEntity = context.create()
                newCategory.name = name
            })
        })
    }
    
}
