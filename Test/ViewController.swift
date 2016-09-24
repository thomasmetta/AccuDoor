//
//  ViewController.swift
//  Test
//
//  Created by TSL030 on 2016-09-24.
//  Copyright © 2016 TSL030. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedAlways {
            locationManager.requestAlwaysAuthorization()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

}

