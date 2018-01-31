//
//  AddingExpensesCoordinator.swift
//  Budget
//
//  Created by Illya on 1/31/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import Foundation
import Domain

class AddExpensesCoordinator: Coordinator {
    let useCaseProvider: Domain.UseCaseProvider
    weak var parent: Coordinator?
    var children: [Coordinator] = []
    var rootViewController: UIViewController?
    
    // MARK: Initialization
    
    init(_ useCaseProvider: Domain.UseCaseProvider) {
        self.useCaseProvider = useCaseProvider
        let navigationController = NavigationController(rootViewController: createMainViewController())
        rootViewController = navigationController
    }
    
    // MARK: Private
    
    private func createMainViewController() -> UIViewController {
        let viewModel = AddExpencesViewModel()
        let viewController = R.storyboard.addExpences.addExpencesViewController()!
        viewController.viewModel = viewModel
        return viewController
    }
    
}
