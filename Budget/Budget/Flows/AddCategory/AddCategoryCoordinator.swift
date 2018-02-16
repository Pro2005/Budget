//
//  AddCategoryCoordinator.swift
//  Budget
//
//  Created by Pro2005 on 2/3/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import Foundation
import Domain
import ReactiveSwift
import Result

class AddCategoryCoordinator: Coordinator {
    let useCaseProvider: Domain.UseCaseProvider
    weak var parent: Coordinator?
    var children: [Coordinator] = []
    var rootViewController: UIViewController?

    // MARK: Initialization
    
    init(_ useCaseProvider: Domain.UseCaseProvider) {
        self.useCaseProvider = useCaseProvider
        let navigationController = NavigationController(rootViewController: createAddCategoryViewController())
        rootViewController = navigationController
    }
    
    // MARK: Private
    
    private func createAddCategoryViewController() -> UIViewController {
        let viewModel = AddCategoryViewController.ViewModel(useCaseProvider)
        viewModel.delegate = self
        let viewController = R.storyboard.addCategory.addCategoryViewController()!
        viewController.viewModel = viewModel
        return viewController
    }
    
}

extension AddCategoryCoordinator: AddCategoryViewModelDelegate {
    
    func addCategoryViewModelDidSave(_ viewModel: AddCategoryViewController.ViewModel) {
        closeAddCategory()
    }
    
    func addCategoryViewModelWantClose(_ viewModel: AddCategoryViewController.ViewModel) {
        closeAddCategory()
    }
    
    private func closeAddCategory() {
        guard let coordinator = parent as? AddCategoryPresentationBahavior else {
            return
        }
        coordinator.closeAddCategory(self)
    }
    
}
