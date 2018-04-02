//
//  LocationDataSource.swift
//  Container
//
//  Created by Reddy on 02/04/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

class LocationDataSource: NSObject {

    fileprivate let tableView: UITableView
    fileprivate var locations = [Location]()
    
    
    init(tableView:UITableView,from path:String) {
        self.tableView = tableView
        super.init()
        
        //rwead data from Plist
        readFromPlist(name: path)
        tableView.dataSource = self
        tableView.reloadData()
        
        
    }
    
    
    func readFromPlist(name:String){
        
        guard let items = NSArray(contentsOfFile:name) as? [Dictionary<String,String>] else {
            return
        }
        
        for item in items {
            
            if let location = Location(dictionary: item){
                locations.append(location)
            }
            
        }
    }
    
    
    func locationAtIndexPath(_ indexPath:IndexPath) -> Location? {
        
        return locations.count > indexPath.row ? locations[indexPath.row] : nil
    }
    
    
}

extension LocationDataSource:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.reuseIdentifer, for: indexPath)
        configure(cell: cell, indexPath: indexPath)
        return cell
    }
    
    private func configure(cell:UITableViewCell, indexPath:IndexPath){
        if let cell = cell as? LocationCell {
            let object = locations[indexPath.row]
            cell.configure(object: object)
        }
        
    }
    
    
}
