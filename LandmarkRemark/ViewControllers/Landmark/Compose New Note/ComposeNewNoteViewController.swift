//
//  ComposeNewNoteViewController.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 21/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase

class ComposeNewNoteViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var postButtonItem: UIBarButtonItem!
    
    var coordinate: CLLocationCoordinate2D!
    var viewModel: ComposeNewNoteViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let coordinate = coordinate {
            viewModel = ComposeNewNoteViewModel(with: coordinate)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard coordinate != nil, viewModel != nil else {
            _ = presentLocationUnavailableAlert()
            return
        }
        textView.becomeFirstResponder()
    }
}


// MARK: - IBActions
extension ComposeNewNoteViewController {
    @IBAction func postButtonTapped(_ sender: UIBarButtonItem) {
    }
}


// MARK: - UI Logic
extension ComposeNewNoteViewController {
    func presentLocationUnavailableAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Unable to publish note", message: "Current location is not available.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
        return alert
    }
    
    func presentAlert(withError error: Error) -> UIAlertController {
        let alert = UIAlertController(title: "Unable to publish note", message: "Error: \(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
        return alert
    }
}
