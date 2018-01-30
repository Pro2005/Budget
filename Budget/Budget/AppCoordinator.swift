//
//  AppCoordinator.swift
//  Budget
//
//  Created by Illya on 1/30/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import UIKit
import Domain

class AppCoordinator: Coordinator {
    let useCaseProvider: UseCaseProvider
    weak var parent: Coordinator?
    var children: [Coordinator] = []
    private let window: UIWindow
    var rootViewController: UIViewController? {
        return window.rootViewController
    }
    
    // MARK: Initialization
    
    init(with window: UIWindow, useCaseProvider: Domain.UseCaseProvider) {
        self.useCaseProvider = useCaseProvider
        self.window = window
    }
    
    // MARK: Public
    
    func start(with launchScreen: UIViewController) {
        window.rootViewController = launchScreen
        window.makeKeyAndVisible()
        // do async task
        let mainCoordinator = MainCoordinator(useCaseProvider)
        add(child: mainCoordinator)
        window.rootViewController = mainCoordinator.rootViewController
    }
    
}
