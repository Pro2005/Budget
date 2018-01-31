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
        let navigationController = NavigationController(rootViewController: createSelectCategoryViewController())
        rootViewController = navigationController
    }
    
    // MARK: Private
    
    private func createSelectCategoryViewController() -> UIViewController {
        let viewModel = SelectCategoryViewModel()
        let viewController = R.storyboard.addExpences.selectCategoryViewController()!
        viewController.viewModel = viewModel
        return viewController
    }
    
}
