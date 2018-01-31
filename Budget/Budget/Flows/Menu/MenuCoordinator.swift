//
//  MenuCoordinator.swift
//  Budget
//
//  Created by Pro2005 on 1/30/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import Foundation
import Domain

class MenuCoordinator: Coordinator {
    let useCaseProvider: Domain.UseCaseProvider
    weak var parent: Coordinator?
    var children: [Coordinator] = []
    var rootViewController: UIViewController?

    // MARK: Initialization
    
    init(_ useCaseProvider: Domain.UseCaseProvider) {
        self.useCaseProvider = useCaseProvider
        let navigationController = NavigationController(rootViewController: createMainViewController())
        navigationController.setNavigationBarHidden(true, animated: false)
        rootViewController = navigationController
    }
    
    // MARK: Private
    
    private func createMainViewController() -> UIViewController {
        let viewController = R.storyboard.menu.menuViewController()!
        return viewController
    }
    
}
