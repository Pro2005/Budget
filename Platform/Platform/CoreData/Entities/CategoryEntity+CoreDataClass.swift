//
//  CategoryEntity+CoreDataClass.swift
//  Platform
//
//  Created by Pro2005 on 2/13/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//
//

import Foundation
import CoreData
import Domain

@objc(CategoryEntity)
public class CategoryEntity: NSManagedObject {

}

extension CategoryEntity: DomainConvertibleType {
    
    func asDomain() -> Domain.Category {
        return Domain.Category(name: name ?? "")
    }
    
}
