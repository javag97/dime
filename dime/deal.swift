//
//  deal.swift
//  dime
//
//  Created by Javier Garcia on 6/1/18.
//  Copyright © 2018 Javier Garcia. All rights reserved.
//
import MapKit
import Foundation

struct deal : Codable {
    let announcementTitle: String?
    let largeImageUrl: URL?
    let finePrint : String?
    let options: [options]?

}

struct options : Codable {
    let buyUrl : URL?
    let redemptionLocations: [redemptionLocations]?
    struct redemptionLocations : Codable {
        let lng: Double?
        let lat: Double?
    }
}
