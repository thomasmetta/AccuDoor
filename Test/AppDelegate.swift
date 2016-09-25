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
            self.beaconManager?.startMonitoring(for: CLBeaconRegion(proximityUUID: uuid, major: 28899, minor: 29792, identifier: "AppRegion"))
        }
        
        // Notifications
        application.registerUserNotificationSettings(UIUserNotificationSettings(types: UIUserNotificationType.alert, categories: nil))

        return true
    }

    
    func beaconManager(_ manager: Any, didEnter region: CLBeaconRegion) {
        print("beaconManagerdidEnter")
        NetworkingManager.sharedInstance.performWeatherRequest { (response) in
//            if let weatherIcon = response?.hours?[0].IconPhrase {
//                print(weatherIcon)
//                print("hi")
//                var body = "YOLO SWAG"
//                self.loadNotification(body: body)
//            }
//            
            var wearSunglasses: Bool = false
            var bringUmbrella: Bool = false
            var sunglassesString: String = ""
            var umbrellaString: String = ""
            
            for i in 0...11 {
                if((response?.hours?[i].IconPhrase) == "Mostly sunny" || (response?.hours?[i].IconPhrase) == "Sunny") {
                    wearSunglasses = true
                }
                if((response?.hours?[i].PrecipitationProbability)! >= 50) {
                    bringUmbrella = true
                }
            }
            if (wearSunglasses == true) {
                sunglassesString = "Bring Sunglasses"
            }
            if (bringUmbrella == true) {
                umbrellaString = "Bring Umbrella"
            }
            let body = sunglassesString + umbrellaString
            print(body)

            self.loadNotification(body: body)
        }
    }
    
    func loadNotification(body: String) {
        let notification = UILocalNotification()
        notification.alertBody = body
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        //        notification.fireDate = NSDate.
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["title": "epifjs", "UUID": "asdf"] // assign a unique identifier to the notification so that we can retrieve it later
        let date = Date(timeIntervalSinceNow: 0)
        notification.fireDate = date
        UIApplication.shared.scheduleLocalNotification(notification)
        
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

