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
        let navigationController = NavigationController(rootViewController: createMostUsedExpensesViewController())
        rootViewController = navigationController
    }
    
    // MARK: Private
    
    private func createSelectCategoryViewController() -> UIViewController {
        let viewModel = SelectCategoryViewController.ViewModel(useCaseProvider)
        viewModel.delegate = self
        let viewController = R.storyboard.addExpences.selectCategoryViewController()!
        viewController.viewModel = viewModel
        return viewController
    }
    
    private func createMostUsedExpensesViewController() -> UIViewController {
        let viewModel = MostUsedExpensesViewController.ViewModel()
        viewModel.delegate = self
        let viewController = R.storyboard.addExpences.mostUsedExpensesViewController()!
        viewController.viewModel = viewModel
        return viewController
    }
    
}

extension AddExpensesCoordinator: SelectCategoryViewModelDelegate {
    
    func selectCategoryViewModelWantAddCategory(_ viewModel: SelectCategoryViewController.ViewModel) {
        openAddCategory()
    }
    
}

extension AddExpensesCoordinator: MostUsedExpensesViewModelDelegate {
    
    func mostUsedViewModelWantAdd(_ viewModel: MostUsedExpensesViewController.ViewModel) {
        
    }
    
}

extension AddExpensesCoordinator: AddCategoryPresentationBahavior {}
