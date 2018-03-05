//
//  SettingVC.swift
//  AR-Jellyfish
//
//  Created by Tom on 02/02/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {
    
    let soundFile = SoundFile()
    let sound = SoundsEfect()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func RemoveAds(_ sender: Any) {

        PurchaseManager.instance.purchaseRemoveAds {_ in }

    }

    @IBAction func buttonSound(_ sender: Any) {
        sound.playSound(fileName: soundFile.FileName(fileNumber: 4), fileExtension: soundFile.FileExtension(fileNumber: 1))
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
            sound.stopAll()
            
        } else {
            UserDefaults.standard.setValue(Bool(true), forKey: "Music")
            MusicButtonOutlet.setTitle("Music off", for: .normal)
            soundForAll.playSound()
        }
        
    }
  
}
