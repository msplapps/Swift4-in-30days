//
//  UserListViewController.swift
//  Users
//
//  Created by PurushothamReddy on 27/06/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {
    
    var users = [User]()
    let viewModel = UserListViewModel()
    var filteredUsers = [User]()

    @IBOutlet weak var userTableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.title = "Users"
        setupSearchController()
        activityIndicator.startAnimating()
        viewModel.getUsers { (response) in
            self.users = response
            self.userTableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func setupSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search users"
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredUsers = users.filter({( user : User) -> Bool in
            return user.name.lowercased().contains(searchText.lowercased())
        })
        
        userTableView.reloadData()
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPosts"{
            let postsVc = segue.destination as? UserPostsViewController
             let indexpath = sender as! IndexPath
            if isFiltering() {
                postsVc?.selectedUser = filteredUsers[(indexpath.row)]
            }else{
            postsVc?.selectedUser = users[indexpath.row]
            }
        }
    }

}

extension UserListViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredUsers.count
        }
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell
        let user: User
        if isFiltering() {
            user = filteredUsers[indexPath.row]
        } else {
            user = users[indexPath.row]
        }
        
        userCell?.data = user
        return userCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPosts", sender: indexPath)
    }
}

extension UserListViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)

    }
}







