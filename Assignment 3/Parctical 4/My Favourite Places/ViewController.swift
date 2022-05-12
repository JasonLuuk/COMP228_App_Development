//
//  ViewController.swift
//  My Favourite Places
//
//  Created by Jason on 18/11/2021.
//
import MapKit
import UIKit

class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    // Define an action that will be triggered when the user long presses
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer)
    {
        if sender.state == .began
        {
            // Define 2 helper variables to help the user determine if there is an error in the code
            var x = 53.405366
            var y = -2.966351
            // Get the location of the user's click
            let touchPoint = sender.location(in: self.map)
            let newCoordinate = self.map.convert(touchPoint, toCoordinateFrom: self.map)
            // Set the point where the user clicks as a new position
            let location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            var title = ""
            CLGeocoder().reverseGeocodeLocation(location, completionHandler:
            {
                (placemarks, error) in if error != nil
                {
                print(error!)
                }
                else
                {
                if let placemark = placemarks?[0]
                    {
                    if placemark.subThoroughfare != nil
                    {
                        title += placemark.subThoroughfare! + " "
                    }
                    if placemark.thoroughfare != nil { title += placemark.thoroughfare!
                    }
                }
            }
                if title == ""
                {
                    title = "Added \(NSDate())"
                }
                // Define a new annotation
                let annotation = MKPointAnnotation()
                annotation.coordinate = newCoordinate
                annotation.title = title
                self.map.addAnnotation(annotation)
                placesSets!.append(["name":title, "lat": String(newCoordinate.latitude), "lon": String(newCoordinate.longitude)])
            } )
        }
        UserDefaults.standard.set(placesSets, forKey:"mapLocation" )
        
    }
    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // When the user enters not by clicking on the cell
        if(flag)
        {
            guard currentPlace != -1 else { return }
            guard placesSets!.count > currentPlace else { return }
            // Get the name of the current persistent storage
            guard let name = (placesSets![currentPlace] as! Dictionary<String,String>) ["name"] else { return }
            // Get the lat of the current persistent storage array
            guard let lat = (placesSets![currentPlace] as! Dictionary<String,String>)["lat"] else { return }
            // Get the lon of the current persistent storage array
            guard let lon = (placesSets![currentPlace] as! Dictionary<String,String>)["lon"] else { return }
            // Convert string to double in an array
            guard let latitude = Double(lat) else { return }
            // Convert string to double in an array
            guard let longitude = Double(lon) else { return }
            let span = MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
            // Define a 2d position with the lat and lon of the double type above
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            self.map.setRegion(region, animated: true)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = name
            self.map.addAnnotation(annotation)
            print(currentPlace)
        }
        // When the user enters by clicking on the cell
        else
        {
            let annotation = MKPointAnnotation()
            // Define a 2d position with the lat and lon of the argument
            let coordinate = CLLocationCoordinate2D(latitude: 53.406566, longitude: -2.966531)
            // Set the level and position of the current map zoom
            let span = MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
            // Set the level and position of the current map zoom
            let region = MKCoordinateRegion(center: coordinate, span: span)
            self.map.setRegion(region, animated: true)
            annotation.coordinate = coordinate
            annotation.title = "Ashton Building"
            self.map.addAnnotation(annotation)
        }
     
        
        
        
        
        
//        locationManager.delegate = self as CLLocationManagerDelegate
//        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//        map.showsUserLocation = true

        
        // Do any additional setup after loading the view.
    }
    
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//    let locationOfUser = locations[0]
//    let latitude = locationOfUser.coordinate.latitude
//    let longitude = locationOfUser.coordinate.longitude
//    let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//
//    if firstRun {
//    firstRun = false
//    let latDelta: CLLocationDegrees = 0.0025
//    let lonDelta: CLLocationDegrees = 0.0025
//    let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
//    let region = MKCoordinateRegion(center: location, span: span)
//    self.map.setRegion(region, animated: true)
//
//    //the following code is to prevent a bug which affects the zooming of the map to the user's location.
//    //We have to leave a little time after our initial setting of the map's location and span,
//    //before we can start centering on the user's location, otherwise the map never zooms in because the
//    //intial zoom level and span are applied to the setCenter() method call, rather than our "requested"
//    //ones, once they have taken effect on the map.
//    //we setup a timer to set our boolean to true in 5 seconds.
//    _ = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(startUserTracking), userInfo: nil, repeats: false)
//    }
//    if startTrackingTheUser == true { map.setCenter(location, animated: true)
//     
//    }
//    }
//
//    //this method sets the startTrackingTheUser boolean class property to true. Once it's true, subsequent calls
//    //to didUpdateLocations will cause the map to center on the user's location.
//    @objc func startUserTracking() { startTrackingTheUser = true
//    }


    

    
}

