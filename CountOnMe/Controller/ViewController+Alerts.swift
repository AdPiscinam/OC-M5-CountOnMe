//
//  ViewController+Alerts.swift
//  CountOnMe
//
//  Created by Walim Aloui on 15/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import UIKit

extension UIViewController {
  
  
  func sendOperatorErrorMessage() {
    let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déjà mis !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
  }
  
  func sendLaunchNewCalculusErrorMessage() {
    let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
       alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
       return self.present(alertVC, animated: true, completion: nil)
  }
  
  func sendEnterNewExpressionErrorMessage() {
  let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
  alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
  return self.present(alertVC, animated: true, completion: nil)
  }
}
