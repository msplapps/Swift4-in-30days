//
//  HalfTunesTests.swift
//  HalfTunesTests
//
//  Created by Reddy on 30/04/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import XCTest
@testable import HalfTunes


class HalfTunesTests: XCTestCase {
    
    var sessionUnderTest:URLSession!
    
    override func setUp() {
        super.setUp()
        
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sessionUnderTest = nil
        super.tearDown()
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
