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
    private lazy var closeAction: Action<Void, Void, NoError> = {
        return Action(execute: {[weak self] _ in
            return SignalProducer { observer, _ in
                self?.close()
                observer.sendCompleted()
            }
        })
    }()
    // MARK: Initialization
    
    init(_ useCaseProvider: Domain.UseCaseProvider) {
        self.useCaseProvider = useCaseProvider
        let navigationController = NavigationController(rootViewController: createAddCategoryViewController())
        rootViewController = navigationController
    }
    
    // MARK: Private
    
    private func createAddCategoryViewController() -> UIViewController {
        let viewModel = AddCategoryViewController.ViewModel(useCaseProvider)
//        viewModel.didSave.output.producer <~
//        viewModel.didSave.output <~ closeAction.completed
//        closeAction <~ viewModel.didSave.output.on()
//        viewModel.didSave.output.on() <~ closeAction
        closeAction <~ viewModel.didSave.output.co
//        viewModel.didSave.output <~ closeAction.
//        closeAction <~ viewModel.didSave.output
//        closeAction <~ viewModel.wantClose.output
        let viewController = R.storyboard.addCategory.addCategoryViewController()!
        viewController.viewModel = viewModel
        return viewController
    }
    
    private func close() {
        guard let coordinator = parent as? AddCategoryPresentationBahavior else {
            return
        }
        coordinator.closeAddCategory(self)
    }
    
}
