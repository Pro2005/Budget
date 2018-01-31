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
    private lazy var menuCoordinator: MenuCoordinator = {
        return MenuCoordinator(useCaseProvider)
    }()
    private var activeChildCoordinator: Coordinator? {
        set {
            let oldCoordinators = children.filter { $0 !== menuCoordinator }
            oldCoordinators.forEach { (coordinator) in
                remove(child: coordinator)
                if let viewController = coordinator.rootViewController {
                    removeChild(viewController)
                }
            }
            guard let newCoordinator = newValue else {
                return
            }
            add(child: newCoordinator)
            if let viewController = newCoordinator.rootViewController {
                addChild(viewController, insertSubviewAt: ContainerZIndex.content.rawValue)
            }
        }
        get {
            return children.filter {$0 !== menuCoordinator}.first
        }
    }
    private enum ContainerZIndex: Int {
        case content
        case menu
    }
    private enum MenuState {
        case collapsed
        case expanded
    }
    private var menuState = MenuState.expanded
    private var shouldSkipGestureForNow = false
    
    // MARK: Initialization
    
    init(_ useCaseProvider: Domain.UseCaseProvider) {
        self.useCaseProvider = useCaseProvider
        rootViewController = createContainerViewController()
        addSideMenu()
        activeChildCoordinator = AddExpensesCoordinator(useCaseProvider)
        addGestureRecognizer()
        setMenuHidden(true, animated: false)
    }
    
    // MARK: Private
    
    private func createContainerViewController() -> UIViewController {
        let viewController = R.storyboard.main.mainContainerViewController()!
        return viewController
    }
    
    private func addSideMenu() {
        guard let viewController = menuCoordinator.rootViewController else {
            return
        }
        add(child: menuCoordinator)
        addChild(viewController, insertSubviewAt: ContainerZIndex.menu.rawValue)
    }
    
    private func addChild(_ viewController: UIViewController, insertSubviewAt index: Int) {
        rootViewController?.view.insertSubview(viewController.view, at: index)
        rootViewController?.addChildViewController(viewController)
        viewController.didMove(toParentViewController: rootViewController)
    }
    
    private func removeChild(_ viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
    
    private func addGestureRecognizer() {
        guard let view = rootViewController?.view else {
            return
        }
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
}

extension MainCoordinator {
    
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        guard shallSkipping(recognizer) == false, let menuView = menuCoordinator.rootViewController?.view else {
            return
        }
        switch recognizer.state {
        case .began:
            // do nothing
            break
        case .changed:
            var frame = menuView.frame
            frame.origin.x += recognizer.translation(in: recognizer.view).x
            if frame.origin.x > 0 {
                frame.origin.x = 0
            }
            menuView.frame = frame
            recognizer.setTranslation(.zero, in: recognizer.view)
        case .ended, .cancelled, .failed:
            if menuView.center.x >= 0 {
                setMenuHidden(false, animated: true)
            } else {
                setMenuHidden(true, animated: true)
            }
        case .possible:
            // do nothing
            break
        }
    }
    
    private func shallSkipping(_ recognizer: UIPanGestureRecognizer) -> Bool {
        let gestureIsDraggingFromLeftToRight = recognizer.velocity(in: rootViewController?.view).x > 0
        let position = recognizer.location(in: recognizer.view)
        if recognizer.state == .began {
            switch menuState {
            case .collapsed:
                if gestureIsDraggingFromLeftToRight {
                    shouldSkipGestureForNow = position.x > 50
                } else {
                    shouldSkipGestureForNow = true
                }
            case .expanded:
                shouldSkipGestureForNow = gestureIsDraggingFromLeftToRight
            }
        }
        return shouldSkipGestureForNow
    }
    
}

extension MainCoordinator: MenuPresentationBehavior {
    
    func toggleMenu() {
        setMenuHidden(menuState == .expanded, animated: true)
    }
    
    func setMenuHidden(_ hidden: Bool, animated: Bool) {
        let targetPosition = hidden ? -UIScreen.main.bounds.size.width : 0
        menuState = hidden ? .collapsed : .expanded
        
        if animated {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1.0,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {[weak self] in
                self?.menuCoordinator.rootViewController?.view.frame.origin.x = targetPosition
            })
        } else {
            menuCoordinator.rootViewController?.view.frame.origin.x = targetPosition
        }
    }
    
}
