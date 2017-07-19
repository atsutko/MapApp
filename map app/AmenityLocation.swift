//
//  AmenityLocation.swift
//  map app
//
//  Created by Masuhara on 2017/05/24.
//  Copyright © 2017年 takao. All rights reserved.
//

import UIKit
import MapKit

class AmenityLocation: NSObject, MKAnnotation {
    
    var identifier = "Pin"
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var subtitle: String?
    
    
    init(name:String, lat: CLLocationDegrees, long: CLLocationDegrees) {
        title = name
        coordinate = CLLocationCoordinate2DMake(lat, long)
    }
}
