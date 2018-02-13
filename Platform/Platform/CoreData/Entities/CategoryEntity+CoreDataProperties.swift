//
//  CategoryEntity+CoreDataProperties.swift
//  Platform
//
//  Created by Pro2005 on 2/13/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//
//

import Foundation
import CoreData


extension CategoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryEntity> {
        return NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
    }

    @NSManaged public var name: String?

}
