//
//  AppInitializer.swift
//  Budget
//
//  Created by Illya on 1/30/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import UIKit
import Domain
import IQKeyboardManagerSwift

struct AppInitializer {
    
    static func initialize(with window: UIWindow,
                           launchViewController: UIViewController,
                           useCaseProvider: Domain.UseCaseProvider) -> Coordinator {
        setupKeyboardManager()
        let coordinator = AppCoordinator(with: window, useCaseProvider: useCaseProvider)
        coordinator.start(with: launchViewController)
        return coordinator
    }
    
    private static func setupKeyboardManager() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
    }
    
}
