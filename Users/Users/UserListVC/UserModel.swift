//
//  UserModel.swift
//  Users
//
//  Created by PurushothamReddy on 27/06/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import Foundation

struct User:Decodable {
    let name:String
    let id:Int
    let company:Company
}
struct Company:Decodable {
    let bs:String
    let name:String
    let catchPhrase:String
}
