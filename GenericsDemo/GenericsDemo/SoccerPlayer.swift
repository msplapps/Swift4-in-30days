//
//  SoccerPlayer.swift
//  GenericsDemo
//
//  Created by PurushothamReddy on 10/07/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import Foundation

struct SoccerPlayer: Searchable {
    
    var query: String {
        return name
    }
    let name: String
}
