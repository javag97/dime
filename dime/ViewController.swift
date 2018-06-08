//
//  ViewController.swift
//  dime
//
//  Created by Javier Garcia on 5/26/18.
//  Copyright © 2018 Javier Garcia. All rights reserved.
//

//        locationTest.coordinate = coordinate
//        locationTest.title = "Starbucks Happy Hour"
//        locationTest.subtitle = "Receive 50% off grande or larger handcrafted Starbucks® Lattes or Macchiatos."
//        print(locationTest)
//        map.addAnnotation(locationTest)


//        let coordinate = CLLocationCoordinate2DMake(35.252909,-120.68741)
//        let span = MKCoordinateSpanMake(0.003, 0.003)
//        let region = MKCoordinateRegionMake(coordinate, span)
//        map.setRegion(region, animated:true)

//        let locationTest = MKPointAnnotation()
//        locationTest.coordinate = coordinate
//        locationTest.title = "Starbucks Happy Hour"
//        locationTest.subtitle = "Receive 50% off grande or larger handcrafted Starbucks® Lattes or Macchiatos."
//        print(locationTest)
//        map.addAnnotation(locationTest)
// Do any additional setup after loading the view, typically from a nib.

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    var API: String = "https://partner-api.groupon.com/deals.json?tsToken=US_AFF_0_208613_212556_0"
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managerSetup()

    }
    
    func apiCall(){
        
        guard let url = URL(string: API) else { return }
        URLSession.shared.dataTask(with: url){ (data, response, err) in
            guard let data = data else { return }
            var pins = [MKPointAnnotation?]()
            do{
                let datum = try JSONDecoder().decode(deals.self, from: data)
                
                for item in datum.deals { //iterates through each deal and assigns to a point annotation
                    let locationTest = MKPointAnnotation()
                    
                    if let title = item.title{
                        locationTest.title = title
                    }
                    
                    if let count = item.options?[0].redemptionLocations {
                        for coord in count{
                            locationTest.coordinate = CLLocationCoordinate2DMake(coord.lat!, coord.lng!)
                        }
                    }
                    else{
                        print("no stuff in here")
                    }
                    
                    if let sub = item.finePrint {
                        locationTest.subtitle = sub
                    }
                    
                    if(locationTest.coordinate.latitude != 0.0 || locationTest.coordinate.longitude != 0.0){
                        pins.append(locationTest)
                    }
                    
    
                }
                self.map.addAnnotations(pins as! [MKAnnotation])
            } catch let jsonErr{
                print("Error w/ json:", jsonErr)
            }
          
            
            }.resume()
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation = CLLocationCoordinate2DMake((location?.coordinate.latitude)!, (location?.coordinate.longitude)!)
        changeLocation(currentLocation: myLocation)
        let region = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        self.map.showsUserLocation = true
//        print("----------------UPDATED------------------")
//        print("-----------------------------------------")
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
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.animatesDrop = true
            pinView?.canShowCallout = true
            pinView?.isDraggable = true
            pinView?.pinTintColor = .blue

            let rightButton: AnyObject! = UIButton(type: UIButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = rightButton as? UIView
        }
        else {
            pinView?.annotation = annotation
        }

        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            performSegue(withIdentifier: "couponDetails", sender: self)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

