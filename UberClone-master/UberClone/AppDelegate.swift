//
//  AppDelegate.swift
//  UberClone
//
//  Created by Maria on 5/12/17.
//  Copyright © 2017 Maria Notohusodo. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let configuration = ParseClientConfiguration {
            $0.applicationId = "wgmdTZH4jE2bsMsP8R2pMtaWCYjxl9DmXoVaD4EW"
            $0.clientKey = "Rsugl6eUp6fyg7ei3WeXtohfr3Ik1OsXPNLI5rSz"
            $0.server = "https://parseapi.back4app.com/"
        }
        Parse.initialize(with: configuration)
        return true
    }
}

