//
//  MenuPresentationBehavior.swift
//  Budget
//
//  Created by Pro2005 on 1/31/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import Foundation

protocol MenuPresentationBehavior {
    func toggleMenu()
    func setMenuHidden(_ hidden: Bool, animated: Bool)
}
