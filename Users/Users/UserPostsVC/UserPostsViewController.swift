//
//  UserPostsViewController.swift
//  Users
//
//  Created by PurushothamReddy on 27/06/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

class UserPostsViewController: UIViewController {

    
    var selectedUser:User?
    @IBOutlet weak var postsTableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var userPosts = [Post]()
    let viewModel = UserPostsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Posts"
        loadPosts()
    }
    
    func loadPosts(){
        let userid = selectedUser?.id
        let idStr = "\(userid ?? 0)"
        activityIndicator.startAnimating()
        viewModel.getPosts(for: idStr) { (reponse) in
            self.userPosts = reponse
            self.postsTableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //PostDetails
        if segue.identifier == "PostDetails"{
            let detailVC = segue.destination as? PostDetailViewController
            detailVC?.postOwner = selectedUser
            detailVC?.userPost = userPosts[sender as! Int]
        }
    }
    
}

extension UserPostsViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let post = userPosts[indexPath.row]
        cell.textLabel?.text = post.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PostDetails", sender: indexPath.row)
    }
    
}
