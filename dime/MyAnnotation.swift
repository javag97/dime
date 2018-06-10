//
//  MyAnnotation.swift
//  dime
//
//  Created by Javier Garcia on 6/9/18.
//  Copyright © 2018 Javier Garcia. All rights reserved.
//

import Foundation
import MapKit

class MyAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var image: URL
    var title: String?
    var subtitle: String?
    
    override init() {
        self.coordinate = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        self.image = URL(string: "www.google.com")!
        super.init()
    }
   
}
