//
//  LandmarkViewController.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 21/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import UIKit
import Firebase

class LandmarkViewController: UIViewController {
    
    @IBOutlet weak var logoutButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}


// MARK: - IBActions
extension LandmarkViewController {
    @IBAction func logoutButtonItemTapped(_ sender: UIBarButtonItem) {
        do {
            dismiss(animated: true, completion: nil)
            try Auth.auth().signOut()
        } catch let error {
            debugPrint("Error signing out: \(error.localizedDescription)")
        }
    }
}
