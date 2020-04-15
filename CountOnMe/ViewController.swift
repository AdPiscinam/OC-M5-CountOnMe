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
  
}

class ViewController: UIViewController, AlertDelegate, DataTransmissionDelegate {
  
  //MARK: Properties
  var canAddDecimal: Bool {
    if let element = elements.last {
      if element.contains(".") || element.isEmpty {
        return false
      }
    }
    return true
  }
  
  var elements: [String] {
    return textView.text.split(separator: " ").map { "\($0)" }
  }
  
  var canAddOperator: Bool {
    return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/" && elements.last != "."
  }
  
  var expressionHaveResult: Bool {
    return textView.text.firstIndex(of: "=") != nil
  }
  
  //MARK: Instantiate Model
  var model = Calculation()
  
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
      sendOperatorErrorMessage()
    }
  }
  
  @IBAction func tappedSubstractionButton() {
    if canAddOperator {
      textView.text.append(" - ")
    } else {
      sendOperatorErrorMessage()
    }
  }
  
  @IBAction func tappedMultiplyButton() {
    if canAddOperator {
      textView.text.append(" x ")
    } else {
      sendOperatorErrorMessage()
    }
  }
  
  @IBAction func tappedDivideButton() {
    if canAddOperator {
      textView.text.append(" / ")
    } else {
      sendOperatorErrorMessage()
    }
  }
  
  @IBAction func tappedACButton() {
    textView.text = "0"
  }
  
  @IBAction func tappedEqualButton() {
    model.elements = elements
    model.performCalculation()
    assignCorrectData()
  }
  
  @IBAction func addDecimal() {
    if canAddDecimal {
      textView.text += "."
    }
  }
  
  //MARK: Methods
  func popLaunchNewOperation() {
    sendLaunchNewCalculusErrorMessage()
  }
  
  func popIncorrectExpression() {
    sendEnterNewExpressionErrorMessage()
  }
  
  func assignCorrectData() {
    if model.result.truncatingRemainder(dividingBy: 1) == 0 {
      model.verifiedInteger = Int(model.result)
      print("1 = \(model.verifiedInteger)")
      textView.text = String(model.verifiedInteger)
    } else {
      textView.text = String(model.result)
    }
  }
}
