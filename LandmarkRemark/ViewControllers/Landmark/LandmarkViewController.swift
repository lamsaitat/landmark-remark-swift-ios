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
    
    fileprivate enum ContentViewSegementIndex: Int {
        case mapView = 0
        case listView = 1
    }
    
    @IBOutlet weak var logoutButtonItem: UIBarButtonItem!
    @IBOutlet weak var contentViewSegmentedControl: UISegmentedControl!
    @IBOutlet weak var contentView: UIView!
    
    let locationManager = CLLocationManager()
    var mapViewController: LandmarkMapViewController!
    var listViewController: LandmarkListViewController!
    
    var notes: [Note]! = [Note]() {
        didSet {
            if let listVc = listViewController {
                listVc.viewModel = LandmarkListViewModel(with: notes)
            }
        }
    }
    let ref = Database.database().reference(withPath: Note.databaseName)
    var dbHandle: DatabaseHandle?
    
    deinit {
        if let dbHandle = dbHandle {
            ref.removeObserver(withHandle: dbHandle)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        if let mapViewController = createMapViewController() {
            self.mapViewController = mapViewController
        }
        embed(childViewController: mapViewController)
        
        dbHandle = ref.observe(.value) { [weak self] data in
            self?.notes = data.children.allObjects.compactMap({ [weak self] dataSnapshot -> Note? in
                guard let dataSnapshot = dataSnapshot as? DataSnapshot else {
                    return nil
                }
                return Note(snapshot: dataSnapshot)
            })
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ComposeNewNoteViewController, let location = locationManager.location {
            vc.coordinate = location.coordinate
        }
    }
}


// MARK: - IBActions
extension LandmarkViewController {
    @IBAction func logoutButtonItemTapped(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch let error {
            debugPrint("Error signing out: \(error.localizedDescription)")
        }
    }
    
    @IBAction func contentViewSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        guard let index = ContentViewSegementIndex(rawValue: sender.selectedSegmentIndex) else {
            fatalError("Unknown contentView segment index detected.")
        }
        
        switch index {
        case .mapView:
            if mapViewController == nil {
                mapViewController = createMapViewController()
                
            }
            embed(childViewController: mapViewController)
        case .listView:
            if listViewController == nil {
                listViewController = createListViewController()
                listViewController.viewModel = LandmarkListViewModel(with: notes)
            }
            embed(childViewController: listViewController)
        }
    }
}


extension LandmarkViewController {
    func embed(childViewController child: UIViewController) {
        guard let contentView = contentView, let childView = child.view else {
            debugPrint("WARNING: Views not available for embedding.")
            return
        }
        // Detach current content view.
        if let viewToDetach = contentView.subviews.first {
            let previouslyEmbeddedChild = children.filter { childVc -> Bool in
                return childVc.view == viewToDetach
            }.first
            if let previouslyEmbeddedChild = previouslyEmbeddedChild {
                previouslyEmbeddedChild.willMove(toParent: nil)
                viewToDetach.removeFromSuperview()
                previouslyEmbeddedChild.removeFromParent()
                previouslyEmbeddedChild.didMove(toParent: nil)
            }
        }
        
        if children.contains(child) == false {
            child.willMove(toParent: self)
            addChild(child)
        }
        contentView.addSubview(child.view)
        view.addConstraints([
            NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: childView, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: childView, attribute: .bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: childView, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: childView, attribute: .trailing, multiplier: 1.0, constant: 0)
        ])
        child.didMove(toParent: self)
    }
    
    func createMapViewController() -> LandmarkMapViewController! {
        return storyboard?.instantiateViewController(withIdentifier: "LandmarkMapViewController") as? LandmarkMapViewController
    }
    func createListViewController() -> LandmarkListViewController! {
        return storyboard?.instantiateViewController(withIdentifier: "LandmarkListViewController") as? LandmarkListViewController
    }
}
