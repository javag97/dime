//
//  deal.swift
//  dime
//
//  Created by Javier Garcia on 6/1/18.
//  Copyright © 2018 Javier Garcia. All rights reserved.
//

import Foundation

struct deal : Codable {
    let title: String?
    let mediumImageUrl: URL?
    let finePrint : String?
    let options: [options]?
    struct options : Codable {
        let redemptionLocations: [redemptionLocations]?
        struct redemptionLocations : Codable {
            let lng: Double?
            let lat: Double?
        }
    }
}
