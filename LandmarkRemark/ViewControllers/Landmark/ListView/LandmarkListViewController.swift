//
//  LandmarkListViewController.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 22/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import UIKit

class LandmarkListViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!

    var viewModel: LandmarkListViewModel! = LandmarkListViewModel(with: [Note]()) {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        
        // Taps to dismiss search keyboard.
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleViewTapped)))
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
    
    @objc
    func handleViewTapped(_ recognizer: UIGestureRecognizer) {
        searchBar.resignFirstResponder()
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


// MARK: - UISearchDelegate
extension LandmarkListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        viewModel.isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        if let text = searchBar.text, text.isEmpty == false {
            viewModel.isSearching = true
        } else {
            viewModel.isSearching = false
        }
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.isSearching = true
        viewModel.filterContentForSearchText(searchText)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
