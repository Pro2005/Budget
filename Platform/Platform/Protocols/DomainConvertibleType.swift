//
//  DomainConvertibleType.swift
//  Platform
//
//  Created by Pro2005 on 2/13/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import Foundation

protocol DomainConvertibleType {
    associatedtype DomainType
    
    func asDomain() -> DomainType
}
