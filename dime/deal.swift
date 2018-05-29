//
//  deal.swift
//  dime
//
//  Created by Javier Garcia on 5/27/18.
//  Copyright © 2018 Javier Garcia. All rights reserved.
//

import UIKit

class deal {
    
    var store: String // Store that is tied to a specific place
    var title: String // Short title of Coupon
    var desc: String //In-depth description about Coupon, may contain coupon code
    var img: UIImage //contains thumbnail image for the coupon
    
    init() {
        self.store = ""
        self.title = ""
        self.desc = ""
        self.img = UIImage()
    }

}
