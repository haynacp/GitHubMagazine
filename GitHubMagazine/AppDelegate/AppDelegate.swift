//
//  AppDelegate.swift
//  GitHubMagazine
//
//  Created by Hayna Cardoso on 22/07/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    let mainViewController = RepositoriesViewController()
    let navigationController = UINavigationController(rootViewController: mainViewController)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    
    return true
  }
}
