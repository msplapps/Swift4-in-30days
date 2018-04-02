//
//  LocationsTableViewController.swift
//  Container
//
//  Created by Reddy on 02/04/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

protocol LocationProviderDelegate:class {
    func didSelectLocation(_ location:Location)
}

class LocationsTableViewController: UITableViewController {
    
    weak var delegate:LocationProviderDelegate?
    private var locationDataSource:LocationDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65.0
        tableView.delegate = self
        
        if let plistPath = Bundle.main.path(forResource: "locations", ofType: "plist"){
            locationDataSource = LocationDataSource(tableView: tableView, from: plistPath)
            tableView.dataSource = locationDataSource
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let location = locationDataSource?.locationAtIndexPath(indexPath) {
            delegate?.didSelectLocation(location)
        }
    }
}
