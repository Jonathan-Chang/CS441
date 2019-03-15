//
//  ViewController.swift
//  p4_ffa
//
//  Created by Jonathan on 3/5/19.
//  Copyright © 2019 Jonathan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var tempLabel: UILabel!
    
    
    let apiKey = "5431c4c2cb5030f66134497a943dc2da"
    var latitude = 23.44
    var longitude = 54.2
    
    var activityIndicator: NVActivityIndicatorView!
    let locationManager = CLLocationManager()
    
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let indicatorSize: CGFloat = 70
        let indicatorFrame = CGRect(x: (view.frame.width-indicatorSize)/2, y: (view.frame.height-indicatorSize/2), width: indicatorSize, height: indicatorSize)
        activityIndicator = NVActivityIndicatorView(frame: indicatorFrame, type: .lineScale, color: UIColor.white, padding: 20.0)
        
        activityIndicator.backgroundColor = UIColor.black
        view.addSubview(activityIndicator)
        
        
        locationManager.requestWhenInUseAuthorization()
        
        activityIndicator.startAnimating()
        if(CLLocationManager.locationServicesEnabled())
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let location = locations[0]
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric").responseJSON {
            response in
            self.activityIndicator.stopAnimating()
            if let responseStr = response.result.value{
                let jsonResponse = JSON(responseStr)
                let jsonWeather = jsonResponse["weather"].array![0]
                let jsonTemperature = jsonResponse["main"]
                let iconName = jsonWeather["icon"].stringValue
                self.locationLabel.text = jsonResponse["name"].stringValue
                
                self.conditionImage.image = UIImage(named: iconName)
                self.weatherLabel.text = jsonWeather["main"].stringValue
                self.tempLabel.text = "\(jsonTemperature["temp"])"
                
                
            }
        }
    }

    
    
    

}

