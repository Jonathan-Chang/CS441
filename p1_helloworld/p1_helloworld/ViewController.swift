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
    
    
    @IBAction func onClickHelloWorld(_ sender: Any) {
        
        var all_locations : [CLLocationCoordinate2D] = []
        //Mexico
        all_locations.append(CLLocationCoordinate2DMake(23.624501, -102.55278399999997))
        //France
        all_locations.append(CLLocationCoordinate2DMake(46.227638, 2.213749000000007))
        //Germany
        all_locations.append(CLLocationCoordinate2DMake(23.624501, -102.55278399999997))
        //Kenya
        all_locations.append(CLLocationCoordinate2DMake(23.624501, -102.55278399999997))
        //Russia
        all_locations.append(CLLocationCoordinate2DMake(23.624501, -102.55278399999997))
        //India
        all_locations.append(CLLocationCoordinate2DMake(23.624501, -102.55278399999997))
        //China
        all_locations.append(CLLocationCoordinate2DMake(23.624501, -102.55278399999997))
        //Japan
        all_locations.append(CLLocationCoordinate2DMake(23.624501, -102.55278399999997))
        
        
        
        var new_location = CLLocationCoordinate2DMake(23.634501, -102.55278399999997)
        var span = MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
        var region = MKCoordinateRegion(center: new_location, span: span)
        mapView.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = new_location
        annotation.title = "Mexico"
        annotation.subtitle = "Hola Mundo"
        
        mapView.addAnnotation(annotation)
       
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Location of Binghamton University
        var bing_location = CLLocationCoordinate2DMake(42.0893553, -75.96970490000001)
        
        //span refers to how zoomed in the app is
        var span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        var region = MKCoordinateRegion(center: bing_location, span: span)
        
        //Where the map starts from when the app is started
        mapView.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = bing_location
        annotation.title = "Binghamton University"
        annotation.subtitle = "Hello World!"
        
        
        
        mapView.addAnnotation(annotation)
        
        
        
    }


}

