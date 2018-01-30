//
//  AppDelegate.swift
//  Budget
//
//  Created by Illya on 1/30/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import UIKit
import Domain
import Platform

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy public var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    var coordinator: Coordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let launchViewController = R.storyboard.launchScreen.instantiateInitialViewController()!
        let useCaseProvider = Platform.UseCaseProvider()
        coordinator = AppInitializer.initialize(with: window!, launchViewController: launchViewController, useCaseProvider: useCaseProvider)
        return true
    }

}

