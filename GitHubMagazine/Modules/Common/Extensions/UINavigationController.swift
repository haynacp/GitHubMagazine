//
//  UINavigationController.swift
//  GitHubMagazine
//
//  Created by Hayna Cardoso on 23/07/24.
//

import Foundation
import UIKit

extension UINavigationController {
  func applyTransition() {
    let transition = CATransition()
    transition.duration = 0.3
    transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    transition.type = .moveIn
    transition.subtype = .fromRight
    view.layer.add(transition, forKey: kCATransition)
  }
  
  func popWithTransition() {
    applyTransition()
    popViewController(animated: false)
  }
  
  func pushWithTransition(viewController: UIViewController) {
    applyTransition()
    pushViewController(viewController, animated: false)
  }
}
