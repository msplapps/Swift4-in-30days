//
//  LoginAppUITests.swift
//  LoginAppUITests
//
//  Created by Reddy on 02/05/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import XCTest

class LoginAppUITests: XCTestCase {
    
        let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample(){
        
    }
 
    
    func testLoginUIChanges(){
        
        let loginButton = app.buttons["Login"]
        let cancelButton = app.buttons["Cancel"]
        let enterUserNameTextField = app.textFields["Enter User Name"]
        let enterPasswordTextField = app.textFields["Enter Password"]
        
        
       XCTAssertEqual(loginButton.exists, true)
        XCTAssertEqual(cancelButton.exists, true)
        XCTAssertEqual(enterUserNameTextField.exists, true)
        XCTAssertEqual(enterPasswordTextField.exists, true)
        
    }
    

    
    func testLoginSuccess(){
        
        let enterUserNameTextField = app.textFields["Enter User Name"]
        enterUserNameTextField.tap()
        enterUserNameTextField.typeText("reddy@cleanharbors.com")
        let enterPasswordTextField = app.textFields["Enter Password"]
        enterPasswordTextField.tap()
        enterPasswordTextField.typeText("reddyy1")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Login"].tap()
        
        let alert = app.alerts.firstMatch
        _ = alert.waitForExistence(timeout: TimeInterval(10))
        XCTAssertEqual(alert.label, "Alert")
        
//        let screen = XCUIScreen.main
//        let fullscreenshot = screen.screenshot()
       app.alerts["Alert"].buttons["OK"].tap()
      
        XCTAssertEqual(enterUserNameTextField.value as! String, "reddy@cleanharbors.com")
        XCTAssertEqual(enterPasswordTextField.value as! String, "reddyy1")
        
        app.buttons["Cancel"].tap()
        
    }
    
    func testLoginFailed(){
        
        let enterUserNameTextField = app.textFields["Enter User Name"]
        enterUserNameTextField.tap()
        enterUserNameTextField.typeText("reddy@cleanharbors.com")
        let enterPasswordTextField = app.textFields["Enter Password"]
        enterPasswordTextField.tap()
        enterPasswordTextField.typeText("dummy")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Login"].tap()
        
        let alert = app.alerts.firstMatch
        _ = alert.waitForExistence(timeout: TimeInterval(10))
        XCTAssertEqual(alert.label, "Error")

        app.alerts["Error"].buttons["OK"].tap()
        
        app.buttons["Cancel"].tap()
    }
    
  
    
    
}
