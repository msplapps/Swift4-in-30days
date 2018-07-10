//
//  Reusable.swift
//  GenericsDemo
//
//  Created by PurushothamReddy on 10/07/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

protocol Reusable {
    
}

/// MARK: - UITableView

extension Reusable where Self:UITableViewCell {
    static var reuseIdentifier:String {
        return String(describing: self)
    }
}

extension UITableViewCell:Reusable {
    
}

extension UITableView {
    
    func  register<T:UITableViewCell>(_:T.Type){
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeReusableCell<T:UITableViewCell>(forIdexpath indexPath:IndexPath) -> T{
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else{
            fatalError("Coud not de quecell with this identifier")
        }
       return cell
    }
    
}







