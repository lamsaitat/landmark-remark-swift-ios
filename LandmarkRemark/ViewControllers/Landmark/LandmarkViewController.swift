//
//  LandmarkViewController.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 21/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class LandmarkViewController: UIViewController {
    
    @IBOutlet weak var logoutButtonItem: UIBarButtonItem!
    @IBOutlet weak var contentViewSegmentedControl: UISegmentedControl!
    @IBOutlet weak var contentView: UIView!
    
    let locationManager = CLLocationManager()
    var mapViewController: LandmarkMapViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        if let mapViewController = storyboard?.instantiateViewController(withIdentifier: "LandmarkMapViewController") as? LandmarkMapViewController {
            self.mapViewController = mapViewController
        }
        embed(childViewController: mapViewController)
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


extension LandmarkViewController {
    func embed(childViewController child: UIViewController) {
        guard let contentView = contentView, let childView = child.view else {
            debugPrint("WARNING: Views not available for embedding.")
            return
        }
        if children.contains(child) == false {
            addChild(child)
        }
        contentView.addSubview(child.view)
        view.addConstraints([
            NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: childView, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: childView, attribute: .bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: childView, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: childView, attribute: .trailing, multiplier: 1.0, constant: 0)
        ])
    }
}
