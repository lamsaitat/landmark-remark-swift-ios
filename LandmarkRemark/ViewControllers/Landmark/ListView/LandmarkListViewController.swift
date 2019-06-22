//
//  LandmarkListViewController.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 22/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import UIKit

class LandmarkListViewController: UITableViewController {
    var viewModel: LandmarkListViewModel! = LandmarkListViewModel(with: [Note]()) {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as? NoteCell else {
            return UITableViewCell()
        }
        if let cvm = viewModel.cellViewModel(at: indexPath) {
            configure(cell, withCellViewModel: cvm)
        }
        
        return cell
    }
}


// MARK: - Cell configuration
extension LandmarkListViewController {
    func configure(_ cell: NoteCell, withCellViewModel cellViewModel: NoteCellViewModel) {
        cell.messageLabel.text = cellViewModel.messageLabelDisplayString
        cell.locationLabel.text = cellViewModel.locationLabelDisplayString
        cell.authorLabel.text = cellViewModel.authorLabelDisplayString
    }
}
