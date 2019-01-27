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
    
    var all_locations : [CLLocationCoordinate2D] = []
    var all_locations_titles: [String] = []
    //var all_locations_subtitles: [String] = []
    //Mexico
    var span = MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
    
    
    func return_location(button_counter: Int){
        var region = MKCoordinateRegion(center: all_locations[button_counter], span: span)
        var annotation = MKPointAnnotation()
        annotation.coordinate = all_locations[button_counter]
        annotation.title = all_locations_titles[button_counter]
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
    }
    
    
    
    var button_counter = 0
    
    @IBAction func onClickHelloWorld(_ sender: Any) {
        
        
        
        
        button_counter += 1
        switch(button_counter){
            case 0:
                return_location(button_counter: button_counter)
            case 1:
                return_location(button_counter: button_counter)
            case 2:
                return_location(button_counter: button_counter)
            case 3:
                return_location(button_counter: button_counter)
            case 4:
                return_location(button_counter: button_counter)
            case 5:
                return_location(button_counter: button_counter)
            case 6:
                return_location(button_counter: button_counter)
            case 7:
                return_location(button_counter: button_counter)
            case 8:
                return_location(button_counter: button_counter)
                button_counter = -1
            
        default:
            print("Fail")
        }
        
        
        
        /*
        for i in 0...7{
            
            var region = MKCoordinateRegion(center: all_locations[i], span: span)
            print(region)
            
            var annotation = MKPointAnnotation()
            annotation.coordinate = all_locations[i]
            
            annotation.title = all_locations_titles[i]
            
            
            mapView.addAnnotation(annotation)
            mapView.setRegion(region, animated: true)
           
            
        }*/
        
        /*
        var new_location = CLLocationCoordinate2DMake(23.634501, -102.55278399999997))
        var span = MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
        var region = MKCoordinateRegion(center: new_location, span: span)
        mapView.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = new_location
        annotation.title = "Mexico"
        annotation.subtitle = "Hola Mundo"
        
        mapView.addAnnotation(annotation)
       */
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        all_locations.append(CLLocationCoordinate2DMake(42.0893553, -75.96970490000001))
        all_locations_titles.append("Binghamton University")
        //Mexico
        all_locations.append(CLLocationCoordinate2DMake(23.624501, -102.55278399999997))
        all_locations_titles.append("Mexico")
        //France
        all_locations.append(CLLocationCoordinate2DMake(46.227638, 2.213749000000007))
        all_locations_titles.append("France")
        //Germany
        all_locations.append(CLLocationCoordinate2DMake(51.165691,10.451526000000058))
        all_locations_titles.append("Germany")
        //Kenya
        all_locations.append(CLLocationCoordinate2DMake(-0.023559,37.90619300000003))
        all_locations_titles.append("Kenya")
        //Russia
        all_locations.append(CLLocationCoordinate2DMake(61.52401,105.31875600000001))
        all_locations_titles.append("Russia")
        //India
        all_locations.append(CLLocationCoordinate2DMake(20.593684,78.96288000000004))
        all_locations_titles.append("India")
        //China
        all_locations.append(CLLocationCoordinate2DMake(35.86166,104.19539699999996))
        all_locations_titles.append("China")
        //Japan
        all_locations.append(CLLocationCoordinate2DMake(36.204824,138.252924))
        all_locations_titles.append("Japan")
        // Location of Binghamton University
        var bing_location = all_locations[0]
        
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

