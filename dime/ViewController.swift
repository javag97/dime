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
    @IBOutlet weak var refresh: UIButton!
    @IBAction func refreshedAnnotations(_ sender: UIButton) {
        //map.removeAnnotations(map.annotations)
        changeLocation(currentLocation: map.centerCoordinate)
    }
    
    var API: String = "https://partner-api.groupon.com/deals.json?tsToken=US_AFF_0_208613_212556_0"
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managerSetup()
        addNavBarImage()
        //changeLocation(currentLocation:)
    }
    
    func addNavBarImage() {
        let navController = navigationController!
        let image = #imageLiteral(resourceName: "dime")
        let imageView = UIImageView(image: image)
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        let bannerX = bannerWidth / 2 - image.size.width / 2
        let bannerY = bannerHeight / 2 - image.size.height / 2
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        refresh.layer.cornerRadius = 5  // hidden corner radius mwhahaha
    }
    
    func apiCall(){ //API Called every time location is updated , this also makes an array of pins
        guard let url = URL(string: API) else { return }
        URLSession.shared.dataTask(with: url){ (data, response, err) in
            guard let data = data else { return }
            var pins = [MyAnnotation?]()
            do{
                let datum = try JSONDecoder().decode(deals.self, from: data)
                for item in datum.deals { //iterates through each deal and assigns to a point annotation
                    let locationTest = MyAnnotation()
                    if let title = item.announcementTitle{
                        locationTest.title = title
                    }
                    if let count = item.options?[0].redemptionLocations { // it is possible for a coupon to be redeemable at multiple locations
                        for coord in count{
                            locationTest.coordinate = CLLocationCoordinate2DMake(coord.lat ?? 0.0, coord.lng ?? 0.0)
                        }
                    }
                    else{
                        print("no data in here")
                    }
                    if let sub = item.finePrint {
                        locationTest.subtitle = sub
                    }
                    if let link = item.largeImageUrl {
                        locationTest.image = link
                    }
                    if let buyURL = item.options?[0].buyUrl{
                        locationTest.buyURL = buyURL
                    }
                    if(locationTest.coordinate.latitude != 0.0 || locationTest.coordinate.longitude != 0.0){
                        pins.append(locationTest)
                    }
                }//note that I add all the of the pins to the map. Since I'm not using Firebase, I'm just letting MapKit handle the annotations and taking the small hit to memory
                self.map.addAnnotations(pins as! [MyAnnotation])
            } catch let jsonErr{
                    print("Error w/ json:", jsonErr)
              }
        }.resume()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {//called everytime location is updated
        let location = locations.last
        let span = MKCoordinateSpanMake(0.07, 0.07)
        let myLocation = CLLocationCoordinate2DMake((location?.coordinate.latitude)!, (location?.coordinate.longitude)!)
        let region = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        self.map.showsUserLocation = true
    }

//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
//        if newState == MKAnnotationViewDragState.ending {
//            let droppedAt = view.annotation?.coordinate
//            print(droppedAt ?? "coordicate is nil")
//        }
//    }
    
    func managerSetup(){
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        manager.distanceFilter = 300
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {

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
        pinView.isDraggable = false
        pinView.pinTintColor = .blue
        
        let rightButton = UIButton(type: .detailDisclosure)
        pinView.rightCalloutAccessoryView = rightButton
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {//segue when annotation view is pressed
        if control == view.rightCalloutAccessoryView {
            performSegue(withIdentifier: "couponDetails", sender: view.annotation)
        }
    }
    
    func changeLocation(currentLocation: CLLocationCoordinate2D){//changes api string to match
        let call = "&lat=" + String(currentLocation.latitude) + "&lng=" + String(currentLocation.longitude) + "&limit=" + String(10)
        if API.contains("&") == true {
            var substrings = API.components(separatedBy: "&")
            API = substrings[0]
            API += call
        }
        else{
            API += call
        }
        print(API)
        apiCall()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {//this is called before a segue is performed
            if let selectedDeal = sender as? MyAnnotation {
                let couponView = segue.destination as! CouponViewController
                couponView.myTitle = selectedDeal.title!
                couponView.myDescription = selectedDeal.subtitle!
                couponView.myImage = selectedDeal.image
                couponView.myLink = selectedDeal.buyURL
            }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

