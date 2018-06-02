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

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    var API: String = "https://partner-api.groupon.com/deals.json?tsToken=US_AFF_0_201236_212556_0"
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managerSetup()
        apiCall()
        let coordinate = CLLocationCoordinate2DMake(35.252909,120.68741)
        print(coordinate)
        let span = MKCoordinateSpanMake(0.003, 0.003)
        let region = MKCoordinateRegionMake(coordinate, span)
        map.setRegion(region, animated:true)
        
        let locationTest = MKPointAnnotation()
        locationTest.coordinate = coordinate
        locationTest.title = "Test Coupon"
        locationTest.subtitle = "Save 40% off NeXT Computers"
        map.addAnnotation(locationTest)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.animatesDrop = true
            pinView?.canShowCallout = true
            pinView?.isDraggable = true
            pinView?.pinTintColor = .purple
            
            let rightButton: AnyObject! = UIButton(type: UIButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = rightButton as? UIView
        }
        else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    func apiCall(){
      
        guard let url = URL(string: API) else { return }
        URLSession.shared.dataTask(with: url){ (data, response, err) in
            guard let data = data else { return }
            
//            let dataAsString = String(data: data, encoding: .utf8)
//            print(dataAsString)
//            print all data in JSON
            
            do{
                let datum = try JSONDecoder().decode(deals.self, from: data)
                print(datum)
            } catch let jsonErr{
                print("Error w/ json:", jsonErr)
            }
            
            }.resume()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        self.map.showsUserLocation = true
        var currentLocation: CLLocation!
        
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            currentLocation = manager.location
        }
        else{
        changeLocation(currentLocation: currentLocation)
        }
    }
    
    
    func changeLocation(currentLocation: CLLocation){
        let longitude = "&lat=" + String(currentLocation.coordinate.latitude)
        let latitude = "&lng=" + String(currentLocation.coordinate.longitude)
        let offset = "&offset=" + String(0)
        let limit = "&limit=" + String(1)
        let variables: String = longitude + latitude + offset + limit
        if API.count != 75 {
            var substrings = API.components(separatedBy: "&")
            API = substrings[0]
            API += variables
            
        }
        else{
            API+=variables
        }
    }
   
    
    func managerSetup(){
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    

    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            performSegue(withIdentifier: "couponDetails", sender: view)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print(#function)
        if control == view.rightCalloutAccessoryView {
            performSegue(withIdentifier: "couponDetails", sender: self)
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        if newState == MKAnnotationViewDragState.ending {
            let droppedAt = view.annotation?.coordinate
            print(droppedAt ?? "coordicate is nil")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

