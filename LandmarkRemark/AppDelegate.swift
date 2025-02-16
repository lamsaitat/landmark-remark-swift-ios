//
//  AppDelegate.swift
//  LandmarkRemark
//
//  Created by Sai Tat Lam on 19/6/19.
//  Copyright © 2019 Sai Tat Lam. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        // Adds a listener to handle the transition of app's root view controller
        // based on auth state.
        Auth.auth().addStateDidChangeListener { (_, user) in
            self.applyRootViewController(for: user)
        }
        applyRootViewController(for: Auth.auth().currentUser)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


// MARK: - Additional methods
extension AppDelegate {
    func createLoginViewController() -> LoginViewController {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            fatalError("Unable to instantiate LoginViewController instance")
        }
        return vc
    }
    
    func createLandmarkViewController() -> LandmarkViewController {
        guard let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LandmarkNavController") as? UINavigationController, let vc = navController.viewControllers.first as? LandmarkViewController else {
            fatalError("Unable to instantiate LandmarkViewController instance")
        }
        return vc
    }
    
    func applyRootViewController(for user: Firebase.User?) {
        if user == nil {
            UIApplication.shared.keyWindow?.rootViewController = createLoginViewController()
        } else {
            UIApplication.shared.keyWindow?.rootViewController = createLandmarkViewController().navigationController
        }
    }
}
