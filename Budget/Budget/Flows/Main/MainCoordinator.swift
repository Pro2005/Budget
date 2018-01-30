//
//  MainCoordinator.swift
//  Budget
//
//  Created by Pro2005 on 1/30/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import UIKit
import Domain

class MainCoordinator: Coordinator {
    let useCaseProvider: Domain.UseCaseProvider
    weak var parent: Coordinator?
    var children: [Coordinator] = []
    var rootViewController: UIViewController?
    
    // MARK: Initialization
    
    init(_ useCaseProvider: Domain.UseCaseProvider) {
        self.useCaseProvider = useCaseProvider
        rootViewController = createContainerViewController()
    }
    
    // MARK: Private
    
    private func createContainerViewController() -> UIViewController {
        let viewController = R.storyboard.main.mainContainerViewController()!
        return viewController
    }
    
}
