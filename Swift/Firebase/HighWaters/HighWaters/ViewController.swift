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
    
    //Best-> going to work really hard to find location
    //Will impact on memory and battery life
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest

    //None-> We don't care where we should start to find the location.
    self.locationManager.distanceFilter = kCLDistanceFilterNone

    //Ask permission for privacy -> edit Info.Plist is required
    self.locationManager.requestWhenInUseAuthorization()
    
    self.mapView.showsUserLocation = true
    self.mapView.delegate = self
    
    //Updating the location
    self.locationManager.startUpdatingLocation()

    
    setupUI()
    // Do any additional setup after loading the view.
  }
  
  private func setupUI(){
    let addFloodButton = UIButton(frame: CGRect.zero)
    addFloodButton.setImage(UIImage(named:"plus"), for: .normal)
    
    addFloodButton.addTarget(self, action: #selector(addFloodAnnotationButtonPressed), for: .touchUpInside)
    addFloodButton.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(addFloodButton)
    addFloodButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    addFloodButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -55).isActive = true
    addFloodButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
    addFloodButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
  }
  
  @objc func addFloodAnnotationButtonPressed(sender: Any?){
    
    if let location = self.locationManager.location{
      let floodAnnotation = MKPointAnnotation()
      floodAnnotation.coordinate = location.coordinate
      self.mapView.addAnnotation(floodAnnotation)
    }
    print("addFloodAnnotationButtonPressed")
  }

  //MARK: - to Zoom out to the location
  //will update when the person is moving
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //to get if the konstan is already wrapped
    if let location = locations.first{
      
      //This function will return a lot of coordinates
      let coordinate = location.coordinate
      //How much latitude and logitude to be shown
      let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
      
      //Will set the center as the coordinate and also the span
      let region = MKCoordinateRegion(center: coordinate, span: span)
      //Will change the view to region
      self.mapView.setRegion(region, animated: true)
    }
  }
}

