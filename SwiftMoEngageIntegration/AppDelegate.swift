//
//  AppDelegate.swift
//  SwiftMoEngageIntegration
//
//  Created by Gautam on 26/02/16.
//  Copyright © 2016 MoEngage. All rights reserved.
//

import UIKit
//import <MoEngage-iOS-SDK/MoEngage.h>


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //FIXME: add your key below
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        MoEngage.debug(LOG_ALL)
        
        // Your app id below
        MoEngage.sharedInstance().initializeWithApiKey("my app id", inApplication: application, withLaunchOptions: launchOptions)

        self.sendAppStatusToMoEngage()
        self.saveAppVersionToDefaults()
//        
//        var pData = NSMutableDictionary ()
//        pData.setObject("dsf", forKey: "sdf")
//        pData.removeObjectForKey("sdf")
//        
//        
        
        var dict = Dictionary<String, Array<Int>>()
        
        dict["key"]! += [1]
        dict["key"]!.append(1)
        dict["key"]?.append(1)
        
//        var myDicto = [String : AnyObject?]
        
        let purchaseDict = NSMutableDictionary()
        purchaseDict .setObject("Moto E", forKey: "product")
        purchaseDict .setObject("Mobiles", forKey: "category")
        purchaseDict .setObject(50, forKey: "price")
        
        MoEngage.sharedInstance().trackEvent("Made Purchase", andPayload: purchaseDict)
        
        let myDict = NSMutableDictionary()
        let eventTracker = MOPayloadBuilder.init(dictionary: myDict)
        // Here myDict can be nil or a dictionary with key value pairs for events. myDict will be assigned to eventTracker.eventDict and will be accessible for you to add more events. It is a NSMutableDictionary.
        
        eventTracker.setTimeStamp(1439322197, forKey: "startTime")
        eventTracker.setDate(NSDate(), forKey: "startDate")
        eventTracker.setLocationLat(12.23, lng: 9.23, forKey: "startingLocation")
        
        MoEngage.sharedInstance().trackEvent("Parking", builderPayload: eventTracker)
    
    
        
        return true
    }

    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        
        MoEngage.sharedInstance().didFailToRegisterForPush()
    }
    //MARK: 
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

        MoEngage.sharedInstance().stop(application)
    }

    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        MoEngage.sharedInstance().didReceieveNotificationinApplication(application, withInfo: userInfo)
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        MoEngage.sharedInstance().didRegisterForUserNotificationSettings(notificationSettings)
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        MoEngage.sharedInstance().applicationBecameActiveinApplication(application)
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        MoEngage.sharedInstance().applicationTerminated(application)
    }

    // MARK: Send app status to MoEngage
    func sendAppStatusToMoEngage () {
        if((NSUserDefaults.standardUserDefaults().objectForKey("app version") == nil)){
            MoEngage.sharedInstance().appStatus(INSTALL)
            return
        }
        
        if(self.getAppVersion().floatValue > NSUserDefaults.standardUserDefaults().objectForKey("app version")?.floatValue){
            MoEngage.sharedInstance().appStatus(UPDATE)
        }
    }
    
    func saveAppVersionToDefaults () {
        NSUserDefaults.standardUserDefaults().setObject(self.getAppVersion(), forKey: "app version")
    }
    
    func getAppVersion () -> AnyObject {
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString")!
    }
}

