//
//  GenericTableViewDataSource.swift
//  GenericsDemo
//
//  Created by PurushothamReddy on 10/07/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

protocol Searchable {
    var query: String { get }
}

final class GenericTableViewDataSource<V,T: Searchable>: NSObject,
UITableViewDataSource where V:BaseTableViewCell<T> {
    
    private var models:[T]
    private let configurCell:CellConfiguration
    typealias CellConfiguration = (V,T) -> V
    private var searchResults:[T] = []
    
    private var isSearachActive:Bool = false
    
    init(models:[T],configurCell:@escaping CellConfiguration){
        self.models = models
        self.configurCell = configurCell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearachActive ? searchResults.count : models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:V = tableView.dequeueReusableCell(withIdentifier: V.reuseIdentifier, for: indexPath) as! V
        let model = getModelAt(indexPath)
        return configurCell(cell,model)
    }
    
    private func getModelAt(_ indexPath: IndexPath) -> T {
        return isSearachActive ? searchResults[indexPath.item] :  models[indexPath.item]
    }
    
    
    func search(query:String){
        
        isSearachActive = !query.isEmpty
        searchResults = models.filter{
            let queryToFind = $0.query.range(of:query, options:NSString.CompareOptions.caseInsensitive)
            return queryToFind != nil
        }
        
    }
}
