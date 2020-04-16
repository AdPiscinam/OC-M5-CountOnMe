//
//  CalculatorBrain.swift
//  CountOnMe
//
//  Created by Walim Aloui on 12/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

struct Calculation {
  
  //MARK: Properties
  
  var elements = [String]()
  var isMultiplicationOrDivisionPresent = false
  var result : Float = 0
  var verifiedInteger : Int = 0
  
  //MARK: Delegation Properties
  var alertDelegate : AlertDelegate?
  var dataTransmissionDelegate : DataTransmissionDelegate?
  var calculus = String()
  
  var expressionIsCorrect: Bool {
    return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/" && elements.last != "."
  }
  
  var expressionHaveEnoughElement: Bool {
    return elements.count >= 3
  }
  
  var canAddOperator: Bool {
     return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/" && elements.last != "."
   }
   
   var expressionHaveResult: Bool {
     return calculus.firstIndex(of: "=") != nil
   }
   
  
  var canAddDecimal: Bool {
    if let element = elements.last {
      if element.contains(".") || element.isEmpty {
        return false
      }
    }
    return true
  }
  
  //MARK: Methods
  mutating func checkPriorities() -> Bool {
    if elements.contains("x") || elements.contains("/") {
      isMultiplicationOrDivisionPresent = true
    } else {
      isMultiplicationOrDivisionPresent = false
    }
    return isMultiplicationOrDivisionPresent
  }
  
  mutating func performPrioritiesCalculation() {
    if elements.indices.contains(2) && checkPriorities(){
      if let element = elements.firstIndex(where: { $0.hasPrefix("x") }) {
        if let value1 = Float(elements[element - 1]), let value2 = Float(elements[element + 1]) {
          result = value1 * value2
          elements[element - 1] = "\(result)"
          elements.remove(at: element + 1)
          elements.remove(at: element)
        }
      }
      if let element = elements.firstIndex(where: { $0.hasPrefix("/") }) {
        if let value1 = Float(elements[element - 1]), let value2 = Float(elements[element + 1]) {
          result = value1 / value2
          elements[element - 1] = "\(result)"
          elements.remove(at: element + 1)
          elements.remove(at: element)
        }
      }
    } else {
      isMultiplicationOrDivisionPresent = false
    }
  }
  
  mutating func performRemainingCalculation() {
    if elements.count > 2  {
      if let element = elements.firstIndex(where: { $0.hasPrefix("+") }) {
        if let value1 = Float(elements[element - 1]), let value2 = Float(elements[element + 1]) {
          result = value1 + value2
          elements[element - 1] = "\(result)"
          elements.remove(at: element + 1)
          elements.remove(at: element)
          
        }
      }

      if let element = elements.firstIndex(where: { $0.description == "-" }) {
        if let value1 = Float(elements[element - 1]), let value2 = Float(elements[element + 1]) {
          result = value1 - value2
          elements[element - 1] = "\(result)"
          elements.remove(at: element + 1)
          elements.remove(at: element)
        }
      }
    }
  }
  
  mutating func performCalculation() {
     
   
    guard expressionIsCorrect else {
      alertDelegate?.popIncorrectExpression()
      return
    }
    guard expressionHaveEnoughElement else {
      alertDelegate?.popLaunchNewOperation()
      return
    }
    
    while checkPriorities() == true  {
      performPrioritiesCalculation()
    }
    while  elements.indices.contains(2) {
      performRemainingCalculation()
    }
     calculus = String(result)
  
  }
  
  func determinIntegerOrDecimal() {
    
  }
  
  
}
