//
//  NameAndPictureCell.swift
//  MVVMTableView
//
//  Created by Reddy on 20/04/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

class NameAndPictureCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var pictureImageView: UIImageView!
    var item: ProfileViewModelItem? {
        didSet {
            // cast the ProfileViewModelItem to appropriate item type
            guard let item = item as? ProfileViewModelNameItem  else {
                return
            }
            nameLabel?.text = item.userName
            pictureImageView?.image = UIImage(named: item.pictureUrl)
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

    }
    
}
