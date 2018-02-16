//
//  MostUsedExpensesViewController.swift
//  Budget
//
//  Created by Illya on 2/16/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import UIKit

class MostUsedExpensesViewController: ViewController {
    @IBOutlet private weak var tableView: UITableView!
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: Actions
    
    @IBAction func addTap() {
        viewModel.add()
    }
    
    // MARK: Private
    
    private func setup() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(R.nib.mostUsedExpensesCell)
    }
    
}

extension MostUsedExpensesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.mostUsedExpensesCell, for: indexPath)!
        cell.viewModel = viewModel.dataSource[indexPath.row]
        return cell
    }
    
}
