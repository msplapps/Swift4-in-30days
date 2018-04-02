//
//  Location.swift
//  Container
//
//  Created by Reddy on 02/04/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    
    var name:String
    var latitude:CLLocationDegrees
    var longitude:CLLocationDegrees
    var coordinate:CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(latitude, longitude)
    }
}

extension Location {
    
    init?(dictionary:Dictionary<String,String>) {
        guard let name = dictionary["name"],
        let latitudeTxt = dictionary["latitude"],
        let latitude = CLLocationDegrees(latitudeTxt),
        let longitudeTxt = dictionary["longitude"],
            let longitude = CLLocationDegrees(longitudeTxt) else {
                return nil
        }
        
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        
        if !CLLocationCoordinate2DIsValid(coordinate){
            return nil
        }
    }
    
    
    
}
