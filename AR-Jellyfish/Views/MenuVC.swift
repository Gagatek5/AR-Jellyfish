//
//  MenuVC.swift
//  AR-Jellyfish
//
//  Created by Tom on 31/01/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MenuVC: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet weak var CoinLabel: UILabel!
    
    @IBOutlet weak var banner: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.value(forKey: "Coin") != nil
        {
        CoinLabel.text = " Coins: " + String(describing: UserDefaults.standard.value(forKey: "Coin")!)
        }
        
        if UserDefaults.standard.bool(forKey: PurchaseManager.instance.IAP_REMOVE_ADS)
        {
            banner.removeFromSuperview()
        }else {
            
            let request: GADRequest = GADRequest()
            banner.adUnitID = "ca-app-pub-5264924694211893/7256152038"
            banner.rootViewController = self
            banner.load(request)
            banner.delegate = self
        }

    }
    @IBAction func buttonSound(_ sender: Any) {
        SoundsEfect.instance.playSound(fileName: fileName.point.rawValue, fileExtension: fileExtension.wav.rawValue)
    }
}
