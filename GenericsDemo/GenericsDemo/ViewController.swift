//
//  ViewController.swift
//  GenericsDemo
//
//  Created by PurushothamReddy on 09/07/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

class BaseTableViewController<T:BaseCell<U>,U>: UITableViewController {

    let cellId = "cellId"
    var items = [U]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(T.self, forCellReuseIdentifier: cellId)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for:indexPath) as! BaseCell<U>
     //   cell.textLabel?.text = "\(indexPath.row)"
        cell.item = items[indexPath.row]
        return cell
    }


}
class BaseCell<U>:UITableViewCell {
    
    var item:U!
    
//    var item:Any!{
//        didSet{
//            textLabel?.text = item as? String
//        }
//    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        backgroundColor = .yellow
//    }
}

struct Dog {
    var name:String
}

class DogCell: BaseCell<Dog> {
    
    override var item: Dog!{
        didSet{
            textLabel?.text = item.name
        }
    }
}

class SomeListViewControler: BaseTableViewController<DogCell,Dog> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //    items = ["Vinod","Santoosh","Kiran"]
        items = [
            Dog(name: "Pappy"),
            Dog(name: "Juju"),
            Dog(name: "Snoopey")
        ]
    }
    
    
}

