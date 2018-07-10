//
//  BaseTableViewSearchController.swift
//  GenericsDemo
//
//  Created by PurushothamReddy on 10/07/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

class BaseTableViewSearchController<T:BaseTableViewCell<V>,V>:UITableViewController,UISearchBarDelegate where V:Searchable {
    
    private var strongDataSource:GenericTableViewDataSource<T,V>?
    private let searchController = UISearchController(searchResultsController: nil)
    var models: [V] = [] {
        didSet {
            DispatchQueue.main.async {
                self.strongDataSource = GenericTableViewDataSource(models: self.models, configurCell: { cell, model in
                    cell.item = model
                    return cell
                })
                self.tableView.dataSource = self.strongDataSource
                self.tableView.reloadData()
            }
        }
    }
    
    
  override  func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(T.self)
        setUpSearchBar()
    }
    
    func setUpSearchBar(){
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        strongDataSource?.search(query: searchText)
        self.tableView.reloadData()
    }
    
    
}
