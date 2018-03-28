//
//  SettingVC.swift
//  AR-Jellyfish
//
//  Created by Tom on 02/02/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {
    
    let soundForAll = AppDelegate()
    
    @IBOutlet weak var MusicButtonOutlet: UIButton!
    @IBOutlet weak var SoundButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.value(forKey: "Sound")! as! Bool
        {
            SoundButtonOutlet.setTitle("Sound off", for: .normal)
        } else
        {
            SoundButtonOutlet.setTitle("Sound on", for: .normal)
        }
        if UserDefaults.standard.value(forKey: "Music")! as! Bool
        {
            MusicButtonOutlet.setTitle("Music off", for: .normal)

        } else {
           
            MusicButtonOutlet.setTitle("Music on", for: .normal)

        }
    
    }

    @IBAction func restoreAdRemover(_ sender: Any) {
        
        PurchaseManager.instance.restorePurchases { success in
            if success {}
        }
        
    }
    
    @IBAction func RemoveAds(_ sender: Any) {

        PurchaseManager.instance.purchaseRemoveAds {_ in }

    }

    @IBAction func buttonSound(_ sender: Any) {
        SoundsEfect.instance.playSound(fileName: fileName.point.rawValue, fileExtension: fileExtension.wav.rawValue)
    }
    @IBAction func SoundOnOff(_ sender: Any) {
        
        if UserDefaults.standard.value(forKey: "Sound")! as! Bool
        {
            UserDefaults.standard.setValue(Bool(false), forKey: "Sound")
            SoundButtonOutlet.setTitle("Sound on", for: .normal)
            SoundsEfect.approve = false
        } else {
            UserDefaults.standard.setValue(Bool(true), forKey: "Sound")
            SoundButtonOutlet.setTitle("Sound off", for: .normal)
            SoundsEfect.approve = true
            
        }
            
    }
    @IBAction func MusicOnOff(_ sender: Any) {
        
        if UserDefaults.standard.value(forKey: "Music")! as! Bool
        {
            UserDefaults.standard.setValue(Bool(false), forKey: "Music")
            MusicButtonOutlet.setTitle("Music on", for: .normal)
            SoundsEfect.instance.stopAll()
            
        } else {
            UserDefaults.standard.setValue(Bool(true), forKey: "Music")
            MusicButtonOutlet.setTitle("Music off", for: .normal)
            soundForAll.playSound()
        }
        
    }
  
}
