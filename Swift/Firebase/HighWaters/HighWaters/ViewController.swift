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
  
  //Type of Database reference from firebase database
  private var rootRef: DatabaseReference!
  private var locationManager: CLLocationManager!
  
  /*
  Counting the flood,
  but it would be reset everytime the cycle ends
   */
//  private var floodCounter: Int = 0
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //To make sure that rootRef is pointing to database reference
    //Using this root reference, we can create different nodes on firebase
    self.rootRef = Database.database().reference()
    
    self.locationManager = CLLocationManager()
    self.locationManager.delegate = self
    
    /*
    Best-> going to work really hard to find location,
    And will impact on memory and battery life
     */
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest

    //None-> We don't care where we should start to find the location.
    self.locationManager.distanceFilter = kCLDistanceFilterNone

    //Ask permission for privacy -> edit Info.Plist is required
    self.locationManager.requestWhenInUseAuthorization()
    
    self.mapView.showsUserLocation = true
    self.mapView.delegate = self
    
    //Updating the location
    self.locationManager.startUpdatingLocation()

    // Do any additional setup after loading the view.
    setupUI()
    
    //Retrieve data from Firebase, and display it on map control
    populateFloodedRegions()
  }
  
    //MARK: - Retrieve and Annotate from Firebase
  private func populateFloodedRegions(){
    
    //MARK: Trying to Fetch all the flooded regions, and display it on Map
    
    //Use root reference to point the node on which we want to create an observation
    let floodedRegionRef = self.rootRef.child("flooded-regions")
    //to observe
    /*
     The are many things to observe on, but in this case we use the value of the node
     that we observe.
     Once we observe the flooded regions, when we add a new node, deleting a node,
     renaming a node, and updating a node, we'll get the notification (even at the start)
     */
    floodedRegionRef.observe(.value){ snapshot in
      
      //Not the best approach
      self.mapView.removeAnnotations(self.mapView.annotations)
      
      //Capture values of the snapshot as dictionary
      let floodDictionaries = snapshot.value as? [String:Any] ?? [:]
      
      //MARK: iterate over the dictionary
      for (key, _) in floodDictionaries{
        //
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
  
  // MARK: - What button does, if pressed
  @objc func addFloodAnnotationButtonPressed(sender: Any?){
    
    //MARK: To Get the location
    if let location = self.locationManager.location{
      //Properties of Location Manager is to retrieve recent location
      
      //To make Annotation from mapKit
      let floodAnnotation = MKPointAnnotation()
      //place the annotation on the coordinate
      floodAnnotation.coordinate = location.coordinate
      //View it on the map
      self.mapView.addAnnotation(floodAnnotation)
      
      //to get the location now (the coordinate)
      let coordinate = location.coordinate
      //Make the flood object, with the coordinate's latitude and longitude
      let flood = Flood(latitude: coordinate.latitude, longitude: coordinate.longitude)
      
      //MARK: TO FIREBASE
      //Creating root object, especially the child
      let floodedRegionRef = self.rootRef.child("flooded-regions")
      /*
      Make the child from root FloodedRegion by ID that is automatically generated.
      childByAutoId() -> makes automatic generated id
      Id could be made manually, but if there is the same id, the value in firebase would be replaced
       */
      let floodRef = floodedRegionRef.childByAutoId()
      
//      let floodRef = floodedRegionRef.child("flood\(self.floodCounter)")
      
      //MARK: To set the value that is assigned to each ID
      /*
      Firebase is okay with strings, interger floats, double arrays, and dictionaries,
      but not with custom struct or class
      the we should convert flood struct into dictionary using toDictionary
       */
      floodRef.setValue(flood.toDictionary())
      
      //adding the flood count, so the id won't be the same
//      self.floodCounter += 1
    }
    print("addFloodAnnotationButtonPressed")
  }
  

  //MARK: - To Zoom out to the location
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

