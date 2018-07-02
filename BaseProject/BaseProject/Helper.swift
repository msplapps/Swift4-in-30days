//
//  Helper.swift
//  BaseProject
//
//  Created by PurushothamReddy on 28/05/18.
//  Copyright © 2018 CleanHarbors. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    convenience init(title:String? , message:String?, error:Error? = nil,enableDebug:Bool = Settings.shared.enableAlertLogs ){
        var finalMessage = message ?? ""
        if enableDebug, let theError = error {
            finalMessage += "\n\n⬇ DEBUG INFO ⬇\n\n\(theError)"
        }
        self.init(title: title, message: finalMessage, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        addAction(ok)
        
    }
}

struct Settings {
    static var shared = Settings()
    let apiURL: URL
    let isOfflineAccessEnabled: Bool
    let feedItemsPerPage: Int
    let enableAlertLogs:Bool
    
    private init() {
        let path = Bundle.main.path(forResource: "Info", ofType: "plist")!
        let plist = NSDictionary(contentsOfFile: path) as! [AnyHashable: Any]
        let settings = plist["AppSetings"] as! [AnyHashable: Any]
        
        apiURL = URL(string: (settings["ServerBaseURL"] as? String))!
        isOfflineAccessEnabled = (settings["EnableOfflineAccess"] as? Bool)!
        feedItemsPerPage = (settings["FeedItemsPerPage"] as? Int)!
        enableAlertLogs = (settings["enableAlertLogs"] as? Bool)!
        
        print("Settings loaded: \(self)")
    }
}
