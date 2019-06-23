//
//  LandmarkListViewModel.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 22/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import Foundation

class LandmarkListViewModel {
    let noteCellViewModels: [NoteCellViewModel]
    
    var isSearching: Bool = false
    var filteredNoteCellViewModels: [NoteCellViewModel]
    
    required init(with notes: [Note]) {
        noteCellViewModels = notes.map({ note -> NoteCellViewModel in
            return NoteCellViewModel(with: note)
        })
        filteredNoteCellViewModels = [NoteCellViewModel](noteCellViewModels)
    }
}


// MARK: - Table View logic
extension LandmarkListViewModel {
    func cellViewModel(at indexPath: IndexPath) -> NoteCellViewModel? {
        if isSearching == true {
            guard indexPath.row < filteredNoteCellViewModels.count else {
                return nil
            }
            return filteredNoteCellViewModels[indexPath.row]
        } else {
            guard indexPath.row < noteCellViewModels.count else {
                return nil
            }
            return noteCellViewModels[indexPath.row]
        }
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return isSearching ? filteredNoteCellViewModels.count : noteCellViewModels.count
    }
}


// MARK: - Search Logic

extension LandmarkListViewModel {
    func filterContentForSearchText(_ searchText: String?, scope: String = "All") {
        guard let searchText = searchText, searchText.count > 0 else {
            filteredNoteCellViewModels = [NoteCellViewModel](noteCellViewModels)
            return
        }
        filteredNoteCellViewModels = noteCellViewModels.filter({ cvm -> Bool in
            return cvm.note.message.contains(searchText) || cvm.note.authorDisplayName.contains(searchText)
        })
    }
}
