//
//  FriendCell.swift
//  MVVMTableView
//
//  Created by Reddy on 20/04/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var item: Friend? {
        didSet {
            guard let item = item else {
                return
            }
            if let pictureUrl = item.pictureUrl {
                pictureImageView?.image = UIImage(named: pictureUrl)
            }
            nameLabel?.text = item.name
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
        pictureImageView?.layer.cornerRadius = pictureImageView.frame.size.width/2
        pictureImageView?.clipsToBounds = true
        pictureImageView?.contentMode = .scaleAspectFit
        pictureImageView?.backgroundColor = UIColor.lightGray
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
        pictureImageView?.image = nil
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
