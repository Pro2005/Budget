//
//  Sequence+DomainConvertibleType.swift
//  Platform
//
//  Created by Pro2005 on 2/13/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import Foundation

extension Sequence where Iterator.Element: DomainConvertibleType {
    typealias Element = Iterator.Element
    func mapToDomain() -> [Element.DomainType] {
        return map {
            return $0.asDomain()
        }
    }
}
