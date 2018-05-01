//
//  BullsEyeTests.swift
//  BullsEyeTests
//
//  Created by Reddy on 30/04/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import XCTest
@testable import BullsEye


class BullsEyeTests: XCTestCase {
    
    
    var gameUnderTest:BullsEyeGame!
    
    override func setUp() {
        super.setUp()
        gameUnderTest = BullsEyeGame()
        gameUnderTest.startNewGame()
    }
    
    override func tearDown() {
        gameUnderTest = nil
        
        super.tearDown()
    }
    
    func testScoreComputed(){
        let guess = gameUnderTest.targetValue + 5
        _ = gameUnderTest.check(guess: guess)
        XCTAssertEqual(gameUnderTest.scoreRound, 95, "Score computed from guess is wrong")
    }
    
    func testScoreComputedWhenGuessLTTarget(){
        let guess = gameUnderTest.targetValue - 5
        _ = gameUnderTest.check(guess: guess)
        XCTAssertEqual(gameUnderTest.scoreRound, 95, "Score computed from guess is wrong")
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
