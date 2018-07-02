//
//  RecentSearchHandler.swift
//  BaseProject
//
//  Created by PurushothamReddy on 22/06/18.
//  Copyright © 2018 CleanHarbors. All rights reserved.
//


import Foundation

class RecentSearchHandler {
    
    static let shared = RecentSearchHandler()
    private init() {}
    
    private let RecentSearch = "RecentSearch"
    
    func getRecentSearchData() -> [String]? {
        if let data = UserDefaults.standard.array(forKey: RecentSearch) as? [String] {
            return data
        }
        return nil
    }
    
    func saveRecentSearchData(searchedText: String) {
        
        var data : [String] {
            if var recentSearchData = getRecentSearchData(), recentSearchData.count>0 {
                if recentSearchData.count == 10 {
                    recentSearchData = recentSearchData.reversed()
                    recentSearchData.remove(at: 0)
                    recentSearchData = recentSearchData.reversed()
                } else {
                    recentSearchData.append(searchedText)
                }
                return recentSearchData
            }
            return [searchedText]
        }
        
        UserDefaults.standard.set(data, forKey: RecentSearch)
        UserDefaults.standard.synchronize()
    }
    
    func removeData(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
