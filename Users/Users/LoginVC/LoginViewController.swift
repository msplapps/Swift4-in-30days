//
//  LoginViewController.swift
//  Users
//
//  Created by PurushothamReddy on 27/06/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextFld: UITextField!
    @IBOutlet weak var passwordTextFld: UITextField!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginBtn.roundingCorner(radius: 7)
        self.signupBtn.roundingCorner(radius: 7)
        self.hideKeyboardWhenTappedAround()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)

    }
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        
        if checkForFormErrors(){return}else {
            performSegue(withIdentifier: "showUsers", sender: nil)
        }
    }
    
    @IBAction func signupBtnClicked(_ sender: Any) {
        
        self.showAlert(title: "oops", message: "Commimg soon!")
    }

    
    func checkForFormErrors() -> Bool{
        var errors = false
        let title = "Error"
        var message = ""
        if (userNameTextFld.text?.isEmpty)! {
            errors = true
            message += "UserName name empty"
            self.alertWithTitle(title: title, message: message, ViewController: self, toFocus:self.userNameTextFld)
        }else if (passwordTextFld.text?.isEmpty)! {
            errors = true
            message += " password is empty"
            self.alertWithTitle(title: title, message: message, ViewController: self, toFocus:self.passwordTextFld)
            self.passwordTextFld.becomeFirstResponder()
        }
        return errors
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }
}

extension LoginViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextFld {
            passwordTextFld.becomeFirstResponder()
        }else {
            textField.resignFirstResponder()
        }
        
        return true
    }
}


