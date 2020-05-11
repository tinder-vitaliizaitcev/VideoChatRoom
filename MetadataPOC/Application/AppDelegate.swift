//
//  AppDelegate.swift
//  MetadataPOC
//
//  Created by Vitalii Zaitcev on 4/29/20.
//  Copyright © 2020 Vitalii Zaitcev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var appFlow: AppFlow?
    
    var appContext: AppContext?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let appRootViewController = UINavigationController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appRootViewController
        window?.makeKeyAndVisible()

        let context = AppContext()
        self.appContext = context
        
        appFlow = AppFlow(rootViewController: appRootViewController, context: context)        
        
        appFlow?.onStartFlow()
        
        return true
    }
}

