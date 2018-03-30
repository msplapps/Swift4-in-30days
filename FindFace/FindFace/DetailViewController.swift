//
//  DetailViewController.swift
//  FindFace
//
//  Created by Reddy on 30/03/18.
//  Copyright © 2018 CleanHarbors. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var detailFaceImageView: UIImageView!
    @IBOutlet weak var faceNameLabel: UILabel!
    
    var image:UIImage?
    var name:String?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let facename = name, let fImage = image else{
            return
        }
        faceNameLabel.text = facename
        detailFaceImageView.image = fImage
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
