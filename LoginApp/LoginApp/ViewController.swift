//
//  ViewController.swift
//  LoginApp
//
//  Created by Reddy on 02/05/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var user:String?
    var password:String?

    @IBOutlet weak var userFld: UITextField!
    
    @IBOutlet weak var pwdFld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUser()
        userFld.delegate = self
        pwdFld.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUser(){
        self.user = "ypr"
        self.password = "123"
    }
    
    @IBAction func loginTapped(_ sender: Any) {
       // self.view.endEditing(true)
        
        print("login Pressed")
        
        let alert = UIAlertController(title: "Alert", message: "Login success", preferredStyle: .alert)
        let ok_action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            print("You've pressed default");
        }
        alert.addAction(ok_action)
        
        let failedAlert = UIAlertController(title: "Error", message: "Login Failed", preferredStyle: .alert)
        let error_action = UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }
        failedAlert.addAction(error_action)
        
        
        if pwdFld.text != "reddyy1" {
            self.present(failedAlert, animated: true, completion: nil)
        }else {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        userFld.text = ""
        pwdFld.text = ""
        
    }
    
}

extension ViewController:UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == pwdFld {
          // self.view.endEditing(true)
            pwdFld.resignFirstResponder()
        }
        return true
    }
}
