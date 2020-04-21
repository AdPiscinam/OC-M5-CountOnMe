//
//  ViewController+Alerts.swift
//  CountOnMe
//
//  Created by Walim Aloui on 15/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func sendErrorMessage(presenting text: String) {
    let alertVC = UIAlertController(title: "Zéro!", message: text, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
  }

}
