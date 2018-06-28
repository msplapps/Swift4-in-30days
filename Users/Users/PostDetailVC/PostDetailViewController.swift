//
//  PostDetailViewController.swift
//  Users
//
//  Created by PurushothamReddy on 28/06/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    var postOwner:User?
    var userPost:Post?

    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var postTitleLabel: UILabel!
    
    @IBOutlet weak var postBodyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Post details"
        self.userNameLabel.text = postOwner?.name ?? ""
        self.postTitleLabel.text = userPost?.title ?? ""
        self.postBodyLabel.text = userPost?.body ?? ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
