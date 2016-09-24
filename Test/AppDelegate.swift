//
//  AppDelegate.swift
//  Test
//
//  Created by TSL030 on 2016-09-24.
//  Copyright © 2016 TSL030. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ESTBeaconManagerDelegate {

    var window: UIWindow?
    var beaconManager: ESTBeaconManager?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.beaconManager = ESTBeaconManager()
        self.beaconManager?.delegate = self
        
        self.beaconManager?.requestAlwaysAuthorization()
        if let uuid = UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D") {
//            self.beaconManager?.startAdvertising(withProximityUUID: uuid, major: 28899, minor: 29792, identifier: "AppRegion")
            self.beaconManager?.startMonitoring(for: CLBeaconRegion(proximityUUID: uuid, major: 28899, minor: 29792, identifier: "AppRegion"))
        }
        
        
        return true
    }

    
    func beaconManager(_ manager: Any, didEnter region: CLBeaconRegion) {
        print("beaconManagerdidEnter")
        NetworkingManager.sharedInstance.performWeatherRequest { (response) in
            if let temp = response?.hours?[0] {
                print(temp)
                print("hi")
            }
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

