//
//  UIViewController.swift
//  GitHubMagazine
//
//  Created by Hayna Cardoso on 23/07/24.
//

import Foundation
import UIKit

extension UIViewController {
  func presentWithTransition(viewController: UIViewController) {
    let transition = CATransition()
    transition.duration = 0.25
    transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    transition.type = .moveIn
    transition.subtype = .fromRight
    self.view.window!.layer.add(transition, forKey: kCATransition)
    self.present(viewController, animated: false, completion: nil)
  }
}
