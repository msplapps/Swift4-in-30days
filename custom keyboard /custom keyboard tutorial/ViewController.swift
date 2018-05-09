//
//  ViewController.swift
//  custom keyboard tutorial
//
//  Created by PurushothamReddy on 09/05/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtFld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
     txtFld.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

