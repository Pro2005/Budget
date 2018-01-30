//
//  Coordinator.swift
//  Budget
//
//  Created by Illya on 1/30/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import UIKit
import Domain

public protocol Coordinator: class {
    
    var useCaseProvider: Domain.UseCaseProvider { get }
    weak var parent: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var rootViewController: UIViewController? { get }
    
}

extension Coordinator {
    
    func add(child coordinator: Coordinator) {
        coordinator.parent = self
        children.append(coordinator)
    }
    
    func remove(child coordinator: Coordinator) {
        coordinator.parent = nil
        children = children.filter {$0 !== coordinator}
    }
    
}

extension Coordinator {
    
    func root(for coordinator: Coordinator) -> Coordinator {
        guard let parent = coordinator.parent else {
            return coordinator
        }
        return root(for: parent)
    }
    
}
