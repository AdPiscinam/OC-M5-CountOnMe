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

protocol DataTransmissionDelegate {
  func assignCorrectData()
  func assignSign(_: String)
}

class ViewController: UIViewController, AlertDelegate, DataTransmissionDelegate {
  
  //MARK: Properties
  let operatorErrorMessage : String = "Un opérateur est déjà mis !"
  let launchNewCalculusErrorMessage : String = "Veuillez démarrer un nouveau calcul !"
  let newExpressionErrorMessage : String = "Veuillez entrer une expression correcte !"
  
  let formatter = NumberFormatter()
  var elements: [String] {
    return textView.text.split(separator: " ").map { "\($0)" }
  }
  
  //MARK: Instantiate Model
  var model = Calculation()
  
  //MARK: Outlets
  @IBOutlet weak var textView: UITextView!
  @IBOutlet var numberButtons: [UIButton]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  //MARK: Actions
  @IBAction func tappedNumberButton(_ sender: UIButton) {
    if textView.text == "0" {
      textView.text = ""
    }
    guard let numberText = sender.title(for: .normal) else {
      return
    }
    if model.expressionHaveResult {
      textView.text = ""
    }
    textView.text.append(numberText)
     
  }
  
  @IBAction func tappedAdditionButton() {
    assignSign(" + ")
  }
  
  @IBAction func tappedSubstractionButton() {
    assignSign(" - ")
  }
  
  @IBAction func tappedMultiplyButton() {
    assignSign(" * ")
  }
  
  @IBAction func tappedDivideButton() {
    assignSign(" / ")
  }
  
  @IBAction func tappedACButton() {
    textView.text = "0"
  }
  
  @IBAction func tappedEqualButton() {
    // Memorises the previous result if no new calculation is made
    model.elements = elements
    print(model.elements)
    model.performCalculation()
    assignCorrectData()
  }
  
  @IBAction func addDecimal() {
    if model.canAddDecimal {
      textView.text += "."
    }
  }
  
  //MARK: Methods
  func popLaunchNewOperation() {
    sendErrorMessage(presenting: launchNewCalculusErrorMessage)
  }
  
  func popIncorrectExpression() {
    sendErrorMessage(presenting : newExpressionErrorMessage)
  }
  
  func assignCorrectData() {
    textView.text = model.calculus
  }
  
  func assignSign(_ operatorSign : String) {
    textView.text += operatorSign
     
  }
  
}
