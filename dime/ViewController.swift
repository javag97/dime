//
//  ViewController.swift
//  dime
//
//  Created by Javier Garcia on 5/26/18.
//  Copyright © 2018 Javier Garcia. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    var API: String = "https://partner-api.groupon.com/deals.json?tsToken=US_AFF_0_208613_212556_0"
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        var test = MyAnnotation()
        test.image = URL(string: "https://images.unsplash.com/photo-1512990414788-d97cb4a25db3?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8d3313d109d86ac30336aadd47f83880&auto=format&fit=crop&w=1003&q=80")!
        test.title = "hejjo"
        test.subtitle = "piwwow"
        print(test.image)
    
        super.viewDidLoad()
        managerSetup()

    }
    
    func apiCall(){ //API Called every time location is updated , this also makes an array of pins
        guard let url = URL(string: API) else { return }
        URLSession.shared.dataTask(with: url){ (data, response, err) in
            guard let data = data else { return }
            var pins = [MyAnnotation?]()
            do{
                let datum = try JSONDecoder().decode(deals.self, from: data)
                print(type(of: datum))
                
                for item in datum.deals { //iterates through each deal and assigns to a point annotation
                    let locationTest = MyAnnotation()
                    
                    if let title = item.title{
                        locationTest.title = title
                    }
                    if let count = item.options?[0].redemptionLocations { // it is possible for a coupon to be redeemable at multiple locations
                        for coord in count{
                            locationTest.coordinate = CLLocationCoordinate2DMake(coord.lat!, coord.lng!)
                        }
                    }
                    else{
                        print("no data in here")
                    }
                    if let sub = item.finePrint {
                        locationTest.subtitle = sub
                    }
                    if let link = item.mediumImageUrl {
                        locationTest.image = link
                    }
                    
                    if(locationTest.coordinate.latitude != 0.0 || locationTest.coordinate.longitude != 0.0){
                        pins.append(locationTest)
                    }
                }
                self.map.addAnnotations(pins as! [MyAnnotation])
            } catch let jsonErr{
                    print("Error w/ json:", jsonErr)
              }
        }.resume()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {//called everytime location is updated
        let location = locations.last
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation = CLLocationCoordinate2DMake((location?.coordinate.latitude)!, (location?.coordinate.longitude)!)
        changeLocation(currentLocation: myLocation)
        let region = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        self.map.showsUserLocation = true
        apiCall()
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        if newState == MKAnnotationViewDragState.ending {
            let droppedAt = view.annotation?.coordinate
            print(droppedAt ?? "coordicate is nil")
        }
    }
    
    func managerSetup(){
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        manager.distanceFilter = 300
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let reuseId = "pin"
        var pinView = MKPinAnnotationView()
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView.animatesDrop = true
        pinView.canShowCallout = true
        pinView.isDraggable = true
        pinView.pinTintColor = .blue
        
        let rightButton = UIButton(type: .detailDisclosure)
        pinView.rightCalloutAccessoryView = rightButton
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {//
        if control == view.rightCalloutAccessoryView {
            performSegue(withIdentifier: "couponDetails", sender: view.annotation)
        }
    }
    
    func changeLocation(currentLocation: CLLocationCoordinate2D){//changes api string to match
        let call = "&lat=" + String(currentLocation.latitude) + "&lng=" + String(currentLocation.longitude) + "&limit=" + String(20)
        if API.contains("&") == true {
            var substrings = API.components(separatedBy: "&")
            API = substrings[0]
            API += call
        }
        else{
            API += call
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {//this is called before a segue is performed
            print(sender)
            if let selectedDeal = sender as? MyAnnotation {
                let couponView = segue.destination as! CouponViewController
                couponView.myTitle = selectedDeal.title!
                couponView.myDescription = selectedDeal.subtitle!
                couponView.myImage = selectedDeal.image
            }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

