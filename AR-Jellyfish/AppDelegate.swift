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
        if  UserDefaults.standard.value(forKey: UserDefaultsString.userName.rawValue) == nil
        {
            let setNick = storyboard.instantiateViewController(withIdentifier: UserDefaultsString.nick.rawValue) as! SetNickNameVC
            self.window?.rootViewController = setNick
           
            UserDefaults.standard.set(0, forKey: UserDefaultsString.timeMultiply.rawValue)
            UserDefaults.standard.set(0, forKey: UserDefaultsString.bombRemover.rawValue)
            UserDefaults.standard.set(1, forKey: UserDefaultsString.coinMultiply.rawValue)
            UserDefaults.standard.set(1, forKey: UserDefaultsString.score.rawValue)
            UserDefaults.standard.set(30, forKey: UserDefaultsString.coin.rawValue)
        }
        else
        {
            let menu = storyboard.instantiateViewController(withIdentifier: "Menu") as! MenuVC
            self.window?.rootViewController = menu
        }
//        if UserDefaults.standard.value(forKey: "Music")! as! Bool == false
//        {
            playSound()
       // }

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

