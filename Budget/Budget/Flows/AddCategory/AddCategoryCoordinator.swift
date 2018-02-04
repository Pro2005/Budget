//
//  AddCategoryCoordinator.swift
//  Budget
//
//  Created by Pro2005 on 2/3/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import Foundation
import Domain

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
        var viewModel = AddCategoryViewController.ViewModel()
        viewModel.delegate = self
        let viewController = R.storyboard.addCategory.addCategoryViewController()!
        viewController.viewModel = viewModel
        return viewController
    }
    
}

extension AddCategoryCoordinator: AddCategoryViewModelDelegate {

    func viewModelWantClose(_ viewModel: AddCategoryViewController.ViewModel) {
        guard let coordinator = parent as? AddCategoryPresentationBahavior else {
            return
        }
        coordinator.closeAddCategory(self)
    }
    
}
