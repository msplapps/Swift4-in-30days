//
//  MapViewController.swift
//  Container
//
//  Created by Reddy on 02/04/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var zoom: CLLocationDegrees = 10.0
    var coordinate:CLLocationCoordinate2D? {
        didSet{
            if let coordinate = coordinate {
                centerMap(coordinate)
                annotate(coordinate)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    private func centerMap(_ coordinate: CLLocationCoordinate2D) {
        let span = MKCoordinateSpanMake(zoom, zoom)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    private func annotate(_ coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }


}

extension MapViewController:MKMapViewDelegate {
    
    
    private enum AnnotationView:String{
        case pin = "pin"
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
        
        guard let annotation = annotation as? MKPointAnnotation else {
            return nil
        }
        let identifier = AnnotationView.pin.rawValue
        
        guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) else {
            return MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        annotationView.annotation = annotation
        return annotationView
        
    }
    
    
    
    
    
}
