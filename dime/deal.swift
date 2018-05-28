//
//  deal.swift
//  dime
//
//  Created by Javier Garcia on 5/27/18.
//  Copyright © 2018 Javier Garcia. All rights reserved.
//

import Foundation
import UIKit

class deal {
    
    var store: String // Store that is tied to a specific place
    var title: String // Short title of Coupon
    var desc: String //In-depth description about Coupon, may contain coupon code
    var img: UIImage //contains thumbnail image for the coupon
    
    init(store: String, title: String, desc: String, img: UIImage) {
        self.store = store
        self.title = title
        self.desc = desc
        self.img = img
    }

}
