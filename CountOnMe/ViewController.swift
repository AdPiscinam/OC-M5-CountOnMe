//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

protocol AlertDelegate {
  func popIncorrectExpression()
  
  func popLaunchNewOperation()
  
}



class ViewController: UIViewController, AlertDelegate {
  

  
  
  
  var model = Calculation()
 
  
  @IBOutlet weak var textView: UITextView!
  @IBOutlet var numberButtons: [UIButton]!
  
  
  
  
  var elements: [String] {
    return textView.text.split(separator: " ").map { "\($0)" }
  }
  

  
  // Retourne false si le dernier élément n'est pas un chiffre
  var canAddOperator: Bool {
    return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/" && elements.last != "."
  }
  
  // Vérifie si le signe = est bien présent
  var expressionHaveResult: Bool {
    return textView.text.firstIndex(of: "=") != nil
  }
  
  // View Life cycles
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  // View actions
  @IBAction func tappedNumberButton(_ sender: UIButton) {
    if textView.text == "0" {
      textView.text = ""
    }
    guard let numberText = sender.title(for: .normal) else {
      return
    }
    
    if expressionHaveResult {
      textView.text = ""
    }
    textView.text.append(numberText)
    model.elements.append(numberText)
  }
  
  
  
  
  
  @IBAction func tappedAdditionButton() {
    if canAddOperator {
      textView.text.append(" + ")
    } else {
      let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      self.present(alertVC, animated: true, completion: nil)
    }
 
  }
  
  @IBAction func tappedSubstractionButton() {
    if canAddOperator {
      textView.text.append(" - ")
    } else {
      let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      self.present(alertVC, animated: true, completion: nil)
    }
  }
  
  
  @IBAction func tappedMultiplyButton() {
    if canAddOperator {
      textView.text.append(" x ")
    } else {
      let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      self.present(alertVC, animated: true, completion: nil)
    }
  }
  
  @IBAction func tappedDivideButton() {
    if canAddOperator {
      textView.text.append(" / ")
    } else {
      let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      self.present(alertVC, animated: true, completion: nil)
    }
  }
  
  @IBAction func tappedACButton() {
    textView.text = "0"
    print(elements)
  }
  
  @IBAction func tappedEqualButton() {
    
  
   
    model.elements = elements
    model.performCalculation()
    
 
  }

  
  
  func popLaunchNewOperation() {
        let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
  }
  
  func popIncorrectExpression() {
          let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
       alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
       return self.present(alertVC, animated: true, completion: nil)
  }
  
  
}

