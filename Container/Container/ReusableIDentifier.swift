//
//  ReusableIDentifier.swift
//  Container
//
//  Created by Reddy on 02/04/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import Foundation

protocol ReusableIdentifier:class {
    static var reuseIdentifer:String {get}
}

extension ReusableIdentifier{
    static var reuseIdentifer:String {
        return "\(self)"
    }
}
