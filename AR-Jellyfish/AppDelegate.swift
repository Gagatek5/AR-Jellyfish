//
//  AppDelegate.swift
//  AR-Jellyfish
//
//  Created by Tom on 05/01/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
	var BackgroundSound = SoundsEfect()
    var soundFile = SoundFile()
   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        GADMobileAds.configure(withApplicationID: "ca-app-pub-5264924694211893~7612085695")
        PurchaseManager.instance.fetchProducts()
        UserDefaults.standard.setValue(Bool(true), forKey: "Sound")
        UserDefaults.standard.setValue(Bool(true), forKey: "Music")
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if  UserDefaults.standard.value(forKey: "UserName") == nil
        {
            let setNick = storyboard.instantiateViewController(withIdentifier: "SetNick") as! SetNickNameVC
            self.window?.rootViewController = setNick
        }
        else
        {
            let menu = storyboard.instantiateViewController(withIdentifier: "Menu") as! MenuVC
            self.window?.rootViewController = menu
        }
        
       playSound()

        
        return true
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
    func playSound(){
        
        if (UserDefaults.standard.value(forKey: "Music")! as! Bool == true)
        {
            BackgroundSound.playSound(fileName: soundFile.FileName(fileNumber: 0), fileExtension: soundFile.FileExtension(fileNumber: 0), loop: true)
            
        }
    }
    func stopMusic(){
        BackgroundSound.player?.stop()
    }


}

