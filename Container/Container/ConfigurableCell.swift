//
//  ConfigurableCell.swift
//  Container
//
//  Created by Reddy on 02/04/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import Foundation
protocol ConfigurableCell {
    associatedtype Object
    func configure(object:Object)
}
