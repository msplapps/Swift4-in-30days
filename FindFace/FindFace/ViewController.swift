//
//  ViewController.swift
//  FindFace
//
//  Created by Reddy on 29/03/18.
//  Copyright © 2018 CleanHarbors. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextFiled: UITextField!
    
    @IBOutlet weak var faceImageView: UIImageView!
    
    @IBOutlet weak var statusLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.isHidden = true
    }

}


extension ViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        guard let name = textField.text else { return true}
        
        APIClient.faceForPerson(person: name) { (image, success) in
            if success {
                DispatchQueue.main.async {
                    self.statusLabel.isHidden = true
                    self.faceImageView.image = image
                    self.faceImageView.isHidden = false
                }
                
            }else {
                DispatchQueue.main.async {
                    self.statusLabel.isHidden = false
                     self.faceImageView.isHidden = true
                    self.statusLabel.text = "Requested Face Not Found"
                }
                 print("Failed to find Face")
            }
        }
        
        return true
    }
    
 
    
}
