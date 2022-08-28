//
//  ViewController.swift
//  HighWaters
//
//  Created by Muhammad Abdul Fattah on 28/08/22.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
  @IBOutlet weak var mapView: MKMapView!
  
  private var locationManager : CLLocationManager!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.locationManager = CLLocationManager()
    self.locationManager.delegate = self
    

    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    //Best-> going to work really hard to find location
    //Will impact on memory and battery life
    self.locationManager.distanceFilter = kCLDistanceFilterNone
    //None-> We don't care where we should start to find the location.
    
    self.locationManager.requestWhenInUseAuthorization()
    //Ask permission for privacy -> edit Info.Plist is required
    
    self.mapView.showsUserLocation = true
    self.mapView.delegate = self
    
    self.locationManager.startUpdatingLocation()
    
    // Do any additional setup after loading the view.
  }


}

