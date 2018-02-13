//
//  CategoryUseCase.swift
//  Domain
//
//  Created by Illya on 2/13/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import Foundation
import Result
import ReactiveSwift

public protocol CategoryUseCase {
    
    func add(_ name: String) -> SignalProducer<Void, AnyError>
    
}
