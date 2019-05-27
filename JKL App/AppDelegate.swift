//
//  AppDelegate.swift
//  JKL App
//
//  Created by Ramandeep Singh Bakshi on 17/08/17.
//  Copyright © 2017 Ramandeep Singh Bakshi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    
    var window: UIWindow?
    var menuController = DDMenuController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        if (UserDefaults.standard.object(forKey: "userID") != nil)
        {
            self.leftmenu()
            
        }
        else
        {
            self.login()
        }
        
        return true
    }
    
    //FUNCTION FOR LOGIN.
    func login()
    {
        let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginScreen") as UIViewController
        let navigationController = UINavigationController(rootViewController: mainController)
        
        self.window?.rootViewController = navigationController
        
    }
    
    //FUNCTION FOR LEFTMENU BAR IN HOME SCREEN
    func leftmenu()
    {
        let mainController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeScreen") as UIViewController
        let navigationController = UINavigationController(rootViewController: mainController)
        
        let ddmenu = DDMenuController(rootViewController: navigationController)
        let leftviewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuScreen") as UIViewController
        let leftnavController = UINavigationController(rootViewController: leftviewController)
        menuController = ddmenu!
        menuController.leftViewController = leftnavController
        self.window?.rootViewController = menuController
        
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

