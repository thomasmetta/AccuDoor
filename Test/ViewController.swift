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
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "Estimotes")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
   
        }
        locationManager.startRangingBeacons(in: region)
    }

    @IBAction func didPressButton1(_ sender: AnyObject) {
        self.loadView1()
    }
    
    
    @IBAction func didPressButton2(_ sender: AnyObject) {
        self.loadView2()
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
                    print(nearProximity)
                }
          
            }
        }
    }
    
}
