//
//  CalculatorBrain.swift
//  CountOnMe
//
//  Created by Walim Aloui on 12/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

struct Calculation {
  
  var isMultiplicationOrDivisionPresent = false
  var elements = [String]()
  var result : Double = 0

  mutating func checkPriorities() -> Bool {
    if elements.contains("x") || elements.contains("/") {
      isMultiplicationOrDivisionPresent = true
    } else {
      isMultiplicationOrDivisionPresent = false
    }
    return isMultiplicationOrDivisionPresent
  }
  
  mutating func performPrioritesCalculation() {
    if elements.indices.contains(2) && checkPriorities(){
      if let element = elements.firstIndex(where: { $0.hasPrefix("x") }) {
        if let value1 = Double(elements[element - 1]), let value2 = Double(elements[element + 1]) {
          result = value1 * value2
          elements[element - 1] = "\(result)"
          elements.remove(at: element + 1)
          elements.remove(at: element)
       
        }
      }
      if let element = elements.firstIndex(where: { $0.hasPrefix("/") }) {
        if let value1 = Double(elements[element - 1]), let value2 = Double(elements[element + 1]) {
          result = value1 / value2
          elements[element - 1] = "\(result)"
          elements.remove(at: element + 1)
          elements.remove(at: element)
          print(elements)
        }
      }
    } else {
      isMultiplicationOrDivisionPresent = false
    }
 
  }
  
  mutating func performRemainingCalculation() {
    if elements.count > 2  {
      if let element = elements.firstIndex(where: { $0.hasPrefix("+") }) {
        if let value1 = Double(elements[element - 1]), let value2 = Double(elements[element + 1]) {
          result = value1 + value2
          elements[element - 1] = "\(result)"
          elements.remove(at: element + 1)
          elements.remove(at: element)
          print("elements are \(elements)")
        }
      }
      if let element = elements.firstIndex(where: { $0.hasPrefix("-") }) {
        if let value1 = Double(elements[element - 1]), let value2 = Double(elements[element + 1]) {
          result = value1 - value2
          elements[element - 1] = "\(result)"
          elements.remove(at: element + 1)
          elements.remove(at: element)
          
        }
      }
    }
  }
  
  mutating func performCalculation() {
    
    while checkPriorities() == true  {
      performPrioritesCalculation()
       print(result)
    }
 
    while  elements.indices.contains(2) {
      performRemainingCalculation()
      print(result)
    }
 
    
  }
  
  
}
