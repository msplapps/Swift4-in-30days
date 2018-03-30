//
//  ViewController.swift
//  FindFace
//
//  Created by Reddy on 29/03/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextFiled: UITextField!
    
    @IBOutlet weak var faceImageView: UIImageView!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var fullImageBtn: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.isHidden = true
        self.faceImageView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        self.statusLabel.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        fullImageBtn.isEnabled = false
    }
    
    @IBAction func showFullImage(_ sender: Any) {
        
     //   let detailVc = DetailViewController()
        let detailvc = self.storyboard?.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController

        detailvc.image = faceImageView.image!
        detailvc.name = nameTextFiled.text!
        
        self.present(detailvc, animated: true, completion: nil)
    }
    

}


extension ViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        guard let name = textField.text else { return true}
        activityIndicator.startAnimating()
        APIClient.faceForPerson(person: name) { (image, success) in
            if success {
                DispatchQueue.main.async {
                    
                    UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                        self.faceImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                        self.statusLabel.isHidden = true
                        self.faceImageView.image = image
                        self.faceImageView.isHidden = false
                    }, completion: nil)
                    
                    APIClient.centerImageforFace(imageview: self.faceImageView)
                    self.activityIndicator.stopAnimating()
                    self.fullImageBtn.isEnabled = true
                }
                
            }else {
                DispatchQueue.main.async {
                    
                    UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                        self.statusLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
                        self.statusLabel.isHidden = false
                        self.faceImageView.isHidden = true
                        self.statusLabel.text = "\(name) Face Not Found"
                        self.activityIndicator.stopAnimating()
                        self.fullImageBtn.isEnabled = false
                    }, completion: nil)
                    
             
                }
                 print("Failed to find Face")
            }
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.statusLabel.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            self.statusLabel.text = ""
            self.faceImageView.image = nil
            self.statusLabel.isHidden = true
            self.faceImageView.isHidden = true
        }, completion: nil)
        
    }
    
 
    
}
