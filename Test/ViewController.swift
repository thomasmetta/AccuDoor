//
//  ViewController.swift
//  closest-beacon-demo
//
//  Created by Will Dages on 10/11/14.
//  @willdages on Twitter
//

import UIKit
import CoreLocation
import AVFoundation
class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "Estimotes")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedAlways) {
            locationManager.requestAlwaysAuthorization()
   
        }
        
        locationManager.startRangingBeacons(in: region)
    }

    @IBAction func didPressButton1(_ sender: AnyObject) {
        self.loadNotification(body: "Swag")
    }
    
   
    
    @IBAction func didPressButton2(_ sender: AnyObject) {
        NetworkingManager.sharedInstance.performWeatherRequest { (response) in
            if let temp = response?.hours?[0].temp?.Value {
            }
            var wearSunglasses: Bool = false
            var bringUmbrella: Bool = false
            
            for i in 0...11 {
                if((response?.hours?[i].IconPhrase) == "Mostly sunny" || (response?.hours?[i].IconPhrase) == "Sunny") {
                    wearSunglasses = true
                }
                if((response?.hours?[i].PrecipitationProbability)! >= 50) {
                    bringUmbrella = true
                }
            }
            print(wearSunglasses)
            print(bringUmbrella)
            
        }
//        self.loadView2()
    }
    
    func loadNotification(body: String) {
        let notification = UILocalNotification()
        notification.alertBody = body
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        //        notification.fireDate = NSDate.
        //        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
//        notification.soundName = Bundle.main.path(forResource: "baa", ofType: "caf")
//        notification.soundName = "res://baa"
        notification.soundName = "Test/noise.caf"
        notification.userInfo = ["title": "epifjs", "UUID": "asdf"] // assign a unique identifier to the notification so that we can retrieve it later
        let date = Date(timeIntervalSinceNow: 5)
        notification.fireDate = date
        notification.alertTitle = "Swankified app"
        UIApplication.shared.scheduleLocalNotification(notification)
        
        ///////////////////////////////
//        notification.alertLaunchImage = "noise"
        //        if let path = Bundle.main.path(forResource: "baa.caf", ofType: "caf") {
//            var coinSound = URL(fileURLWithPath: path)
//            
//            
//            do {
//                let audioPlayer = try AVAudioPlayer(contentsOf: coinSound)
//                audioPlayer.prepareToPlay()
//                audioPlayer.play()
//            } catch {
//                print("HI")
//            }
//        }
        
        
    }
    
    func loadView1() {
        let viewController = NotificationViewController()
        
        self.present(viewController, animated: false, completion: nil)
    }
    
    func loadView2() {
        
        let viewController = ThomasViewController()
        
        self.present(viewController, animated: false, completion: nil)
    }

    var firstProximity: Int = 0
    var secondProximity: Int = 0
    var nearProximity: Bool = false
    
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
