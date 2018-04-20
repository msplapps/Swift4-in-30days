//
//  AboutCell.swift
//  MVVMTableView
//
//  Created by Reddy on 20/04/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

class AboutCell: UITableViewCell {
    
    @IBOutlet weak var aboutLabel: UILabel!
    
    var item: ProfileViewModelItem? {
        didSet {
            guard  let item = item as? ProfileViewModelAboutItem else {
                return
            }
            aboutLabel?.text = item.about
        }
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
