//
//  AppDelegate.swift
//  Paint
//
//  Created by Christopher REECE on 2/11/15.
//  Copyright (c) 2015 Christopher Reece. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = PaintViewController()
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor.whiteColor()
        
                
        return true
    }
}

