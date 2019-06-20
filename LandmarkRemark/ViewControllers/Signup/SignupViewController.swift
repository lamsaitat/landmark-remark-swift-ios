//
//  SignupViewController.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 20/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet weak var cancelButtonItem: UIBarButtonItem!
    
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
extension SignupViewController {
    @IBAction func cancelButtonItemTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
