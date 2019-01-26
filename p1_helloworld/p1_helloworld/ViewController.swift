//
//  ViewController.swift
//  p1_helloworld
//
//  Created by Jonathan on 1/25/19.
//  Copyright © 2019 Jonathan. All rights reserved.
//

import UIKit

//Provides services for the map app that you see
import MapKit

//Provides services for determining device geographic location
import CoreLocation

class ViewController: UIViewController {
    
    
    @IBOutlet var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var location = CLLocationCoordinate2DMake(42.0893553, -75.96970490000001)
        
        var span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        var region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        
        annotation.title = "Binghamton University"
        
        mapView.addAnnotation(annotation)
        
        
        mapView.showsUserLocation = true
    }


}

