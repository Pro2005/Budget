//
//  AddCategoryPresentationBahavior.swift
//  Budget
//
//  Created by Pro2005 on 2/3/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import Foundation

protocol AddCategoryPresentationBahavior {
    func openAddCategory()
    func closeAddCategory(_ coordinator: Coordinator)
}

extension AddCategoryPresentationBahavior where Self: Coordinator {
    
    func openAddCategory() {
        let coordinator = AddCategoryCoordinator(useCaseProvider)
        guard let viewController = coordinator.rootViewController else {
            return
        }
        add(child: coordinator)
        rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func closeAddCategory(_ coordinator: Coordinator) {
        remove(child: coordinator)
        coordinator.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
}
