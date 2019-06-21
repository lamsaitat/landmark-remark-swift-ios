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
    
    var location: CLLocation!
    var viewModel: ComposeNewNoteViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
    }
}


// MARK: - IBActions
extension ComposeNewNoteViewController {
    @IBAction func postButtonTapped(_ sender: UIBarButtonItem) {
    }
}


// MARK: - UI Logic
