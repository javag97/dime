//
//  location.swift
//  dime
//
//  Created by Javier Garcia on 5/28/18.
//  Copyright © 2018 Javier Garcia. All rights reserved.
//

import Foundation


class location{
    var long: Double //contains longitude data of where the user is
    var lat: Double //contains latitude data of where the user is
    var radius: Double //determines search radius of coupon. default will be 500
    
    
    init() {
        self.long = 0.0
        self.lat = 0.0
        self.radius = 500.0
    }
}
