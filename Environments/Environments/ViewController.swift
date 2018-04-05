//
//  ViewController.swift
//  Environments
//
//  Created by Reddy on 05/04/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit



//Soure: https://medium.com/flawless-app-stories/manage-different-environments-in-your-swift-project-with-ease-659f7f3fb1a6


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkAppEnvironment()
    }

    
    func checkAppEnvironment(){
        
        #if DEVELOPMENT
        print("Dev-Environment")
        
        #else
        print("Prod-Environment")
        #endif
        
        let baseURL = Bundle.main.apiBaseURL
        print(baseURL)
    }

}

extension Bundle {
    
    var apiBaseURL:String {
        
        return object(forInfoDictionaryKey: "serverBaseURL") as? String ?? ""
    }
}
