//
//  ViewController.swift
//  SwiftMoEngageIntegration
//
//  Created by Gautam on 26/02/16.
//  Copyright © 2016 MoEngage. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MOInAppDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Track data on MoEngage
        self.trackMoEngageEvents()
        self.trackMoEngageAttributes()
        
        // If Geofencing needed
        
        MoEngage.sharedInstance().startGeofencingWithLocationManager(nil, andCurrentLocation: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        MoEngage.sharedInstance().handleInAppMessage()
    }
    
    func trackMoEngageEvents () {
        let eventsDict = NSMutableDictionary()
        eventsDict.setObject(34, forKey: "Parking Spot Number")
        eventsDict.setObject("Wisconsin", forKey: "Place")
        
        MoEngage.sharedInstance().trackEvent("Search", andPayload: eventsDict)
    }
    
    func trackMoEngageAttributes () {
//        MoEngage.sharedInstance().setUserAttribute("Gautam", forKey: USER_ATTRIBUTE_USER_FIRST_NAME)
//        MoEngage.sharedInstance().setUserAttribute("gautam@moengage.com", forKey: USER_ATTRIBUTE_USER_EMAIL)
//        MoEngage.sharedInstance().setUserAttribute("gautam@moengage.com", forKey: USER_ATTRIBUTE_UNIQUE_ID)
//        
//        MoEngage.sharedInstance().setUserAttribute("Gautam", forKey: MO_EXP_STORYBOARD)
    }
    
    func inAppButtonClickedWithText(text: String!, andData dataDictionary: [NSObject : AnyObject]!) {
        // Parse the data and send it to your deep linking manager
    }
    
    // To get inbox messages from MoEngage
    func getInboxMessages () -> NSArray {
        var inboxMessagesArray = NSArray()
        inboxMessagesArray = MOInbox.getInboxMessages()
        return inboxMessagesArray
    }
}

