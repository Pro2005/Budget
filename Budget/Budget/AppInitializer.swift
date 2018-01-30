//
//  AppInitializer.swift
//  Budget
//
//  Created by Illya on 1/30/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import UIKit
import Domain

struct AppInitializer {
    
    static func initialize(with window: UIWindow, launchViewController: UIViewController, useCaseProvider: Domain.UseCaseProvider) -> Coordinator {
        let coordinator = AppCoordinator(with: window, useCaseProvider: useCaseProvider)
        coordinator.start(with: launchViewController)
        return coordinator
    }
    
}
