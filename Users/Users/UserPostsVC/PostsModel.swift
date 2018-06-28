//
//  PostsModel.swift
//  Users
//
//  Created by PurushothamReddy on 27/06/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import Foundation

struct Post:Decodable {
    let userId:Int
    let id:Int
    let title:String
    let body:String
}
