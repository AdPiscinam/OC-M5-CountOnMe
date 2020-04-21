//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {
    
  
  var model = Calculation()
 
    override func setUp() {
      super.setUp()
      model.elements = [String]()
       
      model.result = 0.00
      model.verifiedInteger = 0
      model.isMultiplicationOrDivisionPresent = false
   
    }

  func testGivenLastInputIsNotNumeral_WhenCalculationIsMade_ThenSendsFalse() {
    model.elements = ["3", "+", "x"]
    XCTAssertFalse(model.expressionIsCorrect)
  }
  
  func testGivenLastInputIsNotNumeralButDecimal_WhenCalculationIsMade_ThenSendsFalse() {
     model.elements = ["3", "+", "."]
     XCTAssertFalse(model.expressionIsCorrect)
   }
  
  func testGivenExpressionDoesNotHaveEnoughElements_WhenCalculationIsMade_ThenSendsFalse() {
    model.elements = ["3", "+"]
    XCTAssertFalse(model.expressionHaveEnoughElement)
  }
  
  func testGivenExpressionEndsWithDecimal_WhenCalculationIsMade_ThenSendsFalse() {
    model.elements = ["3", "."]
    XCTAssertFalse(model.expressionHaveEnoughElement)
  }
  
  func testGivenExpressionWithPriorities_WhenCalculationIsMade_ThenAnswerIsCorrect() {
    model.elements = ["2", "+", "3", "x", "2"]
    model.performCalculation()
    XCTAssertTrue(model.result == 8)
  }
  
  func testGivenMultiplicationExpression_WhenCalculationIsMade_ThenAnswerIsCorrect() {
    model.elements = ["2", "x", "4"]
    model.performCalculation()
    
    XCTAssertTrue(model.result == 8)
  }
  
  func testGivenDivisionExpression_WhenCalculationIsMade_ThenAnswerIsCorrect() {
     model.elements = ["10", "/", "2"]
     model.performCalculation()
  
     XCTAssertTrue(model.result == 5)
   }
  
  
  func testGivenSumExpression_WhenCalculationIsMade_ThenAnswerIsCorrect() {
    model.elements = ["2", "+", "4"]
    model.performRemainingCalculation()
     
    XCTAssertTrue(model.result == 6)
  }
  
  func testGivenSubExpression_WhenCalculationIsMade_ThenAnswerIsCorrect() {
     model.elements = ["2", "-", "4"]
     model.performRemainingCalculation()
     XCTAssertTrue(model.result == -2)
   }
  func testGivenSumExpression_WhenCalculationIsMade_ThenMultiplicationOrDivisionIsFalse() {
    model.elements = ["2", "+", "4"]
    model.performPrioritiesCalculation()
     
    XCTAssertTrue(model.isMultiplicationOrDivisionPresent == false)
    
  }
  
  func testGivenSumExpression_WhenCalculationIsMade_ThenExpressionIsInCorrect() {
     model.elements = ["2", "+", "4", "x"]
     model.performCalculation()
      
    XCTAssertFalse(((model.alertDelegate?.popIncorrectExpression()) != nil))
     
   }
  
  func testGivenSumExpression_WhenCalculationIsMade_ThenExpressionDoesNotHaveEnoughElements() {
      model.elements = ["2"]
      model.performCalculation()
       
     XCTAssertFalse(((model.alertDelegate?.popLaunchNewOperation()) != nil))
      
    }
  
  func testGivenOperationWithMultiplyFirst_WhenCalculationIsMade_ThenExpectedSolutionIsCorrect() {
     
    model.elements = ["15", "x", "2", "/", "3"]
    model.performCalculation()
    print(model.result)
    XCTAssertTrue(model.result == 10.0)
  }
  
  func testGivenOperationWithDivideFirst_WhenCalculationIsMade_ThenExpectedSolutionIsCorrect() {
     
    model.elements = ["15", "/", "2", "x", "3"]
    model.performCalculation()
    print(model.result)
    XCTAssertTrue(model.result == 22.5)
  }
}
