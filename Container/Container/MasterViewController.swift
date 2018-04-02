//
//  MasterViewController.swift
//  Container
//
//  Created by Reddy on 02/04/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    @IBOutlet weak var topStackView: UIStackView!
    
   fileprivate var locationTableVC:LocationsTableViewController?
   fileprivate var mapVC:MapViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Locations"
        topStackView.axis = axisForSize(view.bounds.size)

    }
    
    func axisForSize(_ size:CGSize) -> UILayoutConstraintAxis {
        return size.width > size.height ? .horizontal : .vertical
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        topStackView.axis = axisForSize(size)
        
    }
   
    // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination
        
       
        if let locationVC = destination as? LocationsTableViewController {
            self.locationTableVC = locationVC
            locationVC.delegate = self
        }
            
        if let mapVC = destination as? MapViewController {
            self.mapVC = mapVC
        }
    }
}

extension MasterViewController: LocationProviderDelegate {
    
    func didSelectLocation(_ location: Location) {
        mapVC?.coordinate = location.coordinate
    }
}
