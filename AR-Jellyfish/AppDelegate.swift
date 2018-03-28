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

    func playSound(){
        if (UserDefaults.standard.value(forKey: "Music")! as! Bool == true)
        {
            SoundsEfect.instance.playSound(fileName: fileName.background.rawValue, fileExtension: fileExtension.mp3.rawValue, loop: true)
            
        }
    }
    func stopMusic(){
        SoundsEfect.instance.player?.stop()
    }


}

