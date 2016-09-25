//
//  ViewController.swift
//  closest-beacon-demo
//
//  Created by Will Dages on 10/11/14.
//  @willdages on Twitter
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var warningView: UIView!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var warningIcon: UIImageView!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    // birds
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var cloud4: UIImageView!
    @IBOutlet weak var bird0: UIImageView!
    @IBOutlet weak var birdIsTheWord: UIImageView!
    
    
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "Estimotes")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedAlways) {
            locationManager.requestAlwaysAuthorization()
        }
        
        NetworkingManager.sharedInstance.performWeatherRequest(completion: {(response) in
            if let currentWeather = response?.hours?[0] {
                if let temp = currentWeather.temp?.Value {
                    self.temperatureLabel.text = "\(temp)°"
                }
                self.locationLabel.text = "Toronto ON, Canada"
                if var conditions = currentWeather.IconPhrase {
//                    conditions = "Sunny"
                    if conditions.contains("Sunny") {
                        self.weatherIcon.image = UIImage(named: "sun.png")
                        self.conditionsLabel.text = conditions
                        self.warningIcon.image = UIImage(named: "sunglasses.png")
                        self.setCloudsAndBirdsHidden(hidden: false)
                        self.warningLabel.text = "SUNNY SKIES"
                        self.warningView.backgroundColor = UIColor(red: 131/255.0, green: 207/255.0, blue: 235/255.0, alpha: 1.0)
                        self.view.backgroundColor = UIColor(red: 137/255.0, green: 216/255.0, blue: 246/255.0, alpha: 1.0)
                    }
                    else{
                        self.weatherIcon.image = UIImage(named: "thunderstorm.png")
                        self.conditionsLabel.text = conditions
                        self.warningLabel.text = "RAIN WARNING"
                        self.warningIcon.image = UIImage(named: "umbrella.png")
                        self.setCloudsAndBirdsHidden(hidden: true)
                        self.warningView.backgroundColor = UIColor(red: 38/255.0, green: 55/255.0, blue: 90/255.0, alpha: 1.0)
                        self.view.backgroundColor = UIColor(red: 22/255.0, green: 43/255.0, blue: 87/255.0, alpha: 1.0)
                    }
                }
            }
        })
        
        locationManager.startRangingBeacons(in: region)
    }

//    @IBAction func didPressButton1(_ sender: AnyObject) {
//        self.loadNotification()
//    }
//    
//   
//    
//    @IBAction func didPressButton2(_ sender: AnyObject) {
//        NetworkingManager.sharedInstance.performWeatherRequest { (response) in
//            if let temp = response?.hours?[0].temp?.Value {
//            }
//            var wearSunglasses: Bool = false
//            var bringUmbrella: Bool = false
//            
//            for i in 0...11 {
//                if((response?.hours?[i].IconPhrase) == "Mostly sunny" || (response?.hours?[i].IconPhrase) == "Sunny") {
//                    wearSunglasses = true
//                }
//                if((response?.hours?[i].PrecipitationProbability)! >= 50) {
//                    bringUmbrella = true
//                }
//            }
//            print(wearSunglasses)
//            print(bringUmbrella)
//            
//        }
//    }
    
    func loadNotification() {
        let notification = UILocalNotification()
        notification.alertBody = "Body"
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        //        notification.fireDate = NSDate.
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["title": "epifjs", "UUID": "asdf"] // assign a unique identifier to the notification so that we can retrieve it later
        let date = Date(timeIntervalSinceNow: 5)
        notification.fireDate = date
        UIApplication.shared.scheduleLocalNotification(notification)
    }

    var firstProximity: Int = 0
    var secondProximity: Int = 0
    var nearProximity: Bool = false
    
    private func setCloudsAndBirdsHidden(hidden: Bool) {
        cloud1.isHidden = hidden
        cloud2.isHidden = hidden
        cloud4.isHidden = hidden
        bird0.isHidden = hidden
        birdIsTheWord.isHidden = hidden
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.unknown }
        if (knownBeacons.count > 0) {
            for beacon in knownBeacons {
                if beacon.major == 28899 {
                    firstProximity = secondProximity
                    secondProximity = beacon.proximity.rawValue
                    if (firstProximity == secondProximity && firstProximity == 1){
                        nearProximity = true
                    } else {
                      nearProximity = false
                    }
                
                }
          
            }
        }
    }
    
}
