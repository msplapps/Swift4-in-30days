//
//  Employee.swift
//  EmpData
//
//  Created by Reddy on 18/04/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

struct Employee: Decodable {
    let Name: String
    let Id: String
    let Title: String
    let DepartmentId: String
    let State: String
    let Username: String
    let PayByMile: String
    let Branch: String
}

struct statusST:Decodable{
    var Success:Bool
    var Message:String
    var ErrorDescription:String
}

struct EmpData:Decodable {
  //  var status:statusST
    var emplolyees:[Employee]
}
