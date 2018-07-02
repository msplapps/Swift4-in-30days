//
//  ViewController.swift
//  DemoForCustomUI
//
//  Created by PurushothamReddy on 27/06/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var headerView:UIView!
    var titleLable:UILabel!
    var numberCollectionView:UICollectionView!
    
    var numbers:[Int] = Array(1...100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderAndTitleLable()
        
        numberCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.view.addSubview(numberCollectionView)
        
        numberCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        numberCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        numberCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        numberCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        numberCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        
        numberCollectionView.register(NumbersCollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
        numberCollectionView.dataSource = self
        numberCollectionView.delegate = self
        
        
    }
    
    func setupHeaderAndTitleLable(){
        headerView = UIView()
        headerView.backgroundColor = .red
        self.view.addSubview(headerView)
        
        titleLable = UILabel()
        titleLable.text = "Numbers"
        titleLable.textAlignment = .center
        titleLable.textColor = .white
        titleLable.font = UIFont(name: titleLable.font.fontName, size: 20)
        headerView.addSubview(titleLable)
        
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        headerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        titleLable.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        titleLable.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.4).isActive = true
        titleLable.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.5).isActive = true
        
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! NumbersCollectionViewCell
        cell.label.text = String(numbers[indexPath.row])
        return cell
        
    }
    
    
    
    
}
