//
//  NSManagedObjectContext+Create.swift
//  Platform
//
//  Created by Pro2005 on 2/13/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    
    func create<T: NSFetchRequestResult>() -> T {
        guard let entity = NSEntityDescription.insertNewObject(forEntityName: String(describing: T.self), into: self) as? T else {
            fatalError()
        }
        return entity
    }
    
}
