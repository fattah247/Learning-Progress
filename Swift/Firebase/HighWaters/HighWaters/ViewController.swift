//
//  ViewController.swift
//  HighWaters
//
//  Created by Muhammad Abdul Fattah on 28/08/22.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseCore
import FirebaseDatabase

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
  @IBOutlet weak var mapView: MKMapView!
  
  private var rootRef: DatabaseReference!
  private var locationManager : CLLocationManager!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    self.rootRef = Database.database().reference()
    
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
    
    populateFloodedRegions()
  }
  
  private func populateFloodedRegions(){
    let floodedRegionRef = self.rootRef.child("flooded-regions")
    
    floodedRegionRef.observe(.value){ snapshot in
      
      //Not the best approach
      self.mapView.removeAnnotations(self.mapView.annotations)
      
      
      let floodDictionaries = snapshot.value as? [String:Any] ?? [:]
      
      for (key, _) in floodDictionaries{
        
        if let floodDict = floodDictionaries[key] as? [String:Any]{
          
          if let flood = Flood(dictionary: floodDict){
            
            DispatchQueue.main.async {
              let floodAnnotation = MKPointAnnotation()
              floodAnnotation.coordinate = CLLocationCoordinate2D(latitude: flood.latitude, longitude: flood.longitude)
              
              self.mapView.addAnnotation(floodAnnotation)
            }
          }
        }
      }
      
    }
    
  }
  
  private func setupUI(){
    
    //To Make a Button
    let addFloodButton = UIButton(frame: CGRect.zero) //CGRect.zero means doesn't have width and height
    
    //Setting up the button using image
    addFloodButton.setImage(UIImage(named:"plus"), for: .normal)
    
    //it's what would happen if button is clicked
    addFloodButton.addTarget(self, action: #selector(addFloodAnnotationButtonPressed), for: .touchUpInside)
    
    //To say that the coder that would create the constraint for the button
    addFloodButton.translatesAutoresizingMaskIntoConstraints = false
   
    //To make the View ->But not yet having width and height
    self.view.addSubview(addFloodButton)
    
    
    //MAKE THE Autolayout
    
    //Anchor to sides
    addFloodButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    addFloodButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -55).isActive = true
    
    //Width and Height
    addFloodButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
    addFloodButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
  }
  
  //It's what should button do, if pressed
  @objc func addFloodAnnotationButtonPressed(sender: Any?){
    
    //To Get the location
    if let location = self.locationManager.location{
      //Properties of Location Manager is to retrieve recent location
      
      //To make Annotation from mapKit
      let floodAnnotation = MKPointAnnotation()
      //place the annotation on the coordinate
      floodAnnotation.coordinate = location.coordinate
      //View it on the map
      self.mapView.addAnnotation(floodAnnotation)
      
      let coordinate = location.coordinate
      let flood = Flood(latitude: coordinate.latitude, longitude: coordinate.longitude)
      
      let floodedRegionRef = self.rootRef.child("flooded-regions")
      let floodRef = floodedRegionRef.childByAutoId()
      floodRef.setValue(flood.toDictionary())
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
//      self.mapView.setRegion(region, animated: true)
    }
  }
}

