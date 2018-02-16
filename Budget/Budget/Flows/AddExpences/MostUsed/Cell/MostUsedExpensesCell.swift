//
//  MostUsedExpensesCell.swift
//  Budget
//
//  Created by Illya on 2/16/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import UIKit

class MostUsedExpensesCell: UITableViewCell {
    static let estimatedHeight: CGFloat = 44
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    
    var viewModel: ViewModel? {
        didSet {
            nameLabel.text = viewModel?.expenseName
            categoryLabel.text = viewModel?.categoryName
            amountLabel.text = viewModel?.amount
        }
    }
}
