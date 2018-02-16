//
//  CategoryCell.swift
//  Budget
//
//  Created by Pro2005 on 2/3/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    var viewModel: ViewModel? {
        didSet {
            titleLabel.text = viewModel?.name
        }
    }
}
