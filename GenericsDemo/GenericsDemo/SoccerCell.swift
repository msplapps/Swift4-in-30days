//
//  SoccerCell.swift
//  GenericsDemo
//
//  Created by PurushothamReddy on 10/07/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

class SoccerCell: BaseTableViewCell<SoccerPlayer> {
    
    override var item: SoccerPlayer? {
        didSet {
            textLabel?.text = item?.name
        }
    }

    

}
