//
//  MenuVC.swift
//  AR-Jellyfish
//
//  Created by Tom on 31/01/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MenuVC: UIViewController {
    
    @IBOutlet weak var CoinLabel: UILabel!
    @IBOutlet weak var banner: GADBannerView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        let requestBigAd = GADRequest()
        requestBigAd.testDevices = [kGADSimulatorID]
        GADRewardBasedVideoAd.sharedInstance().load(requestBigAd, withAdUnitID: "ca-app-pub-5264924694211893/6294738126")
       //UserDefaults.standard.set(1000, forKey: "Coin")
        Player.instance.paymentLevelList()
        if UserDefaults.standard.value(forKey: "Coin") != nil
        {
            CoinLabel.text = " Coins: " + String(describing: UserDefaults.standard.value(forKey: "Coin")!)
        }
        if UserDefaults.standard.bool(forKey: PurchaseManager.instance.IAP_REMOVE_ADS)
        {
            banner.removeFromSuperview()
        }
        else
        {
            let request: GADRequest = GADRequest()
            banner.adUnitID = "ca-app-pub-5264924694211893/7256152038"
            banner.rootViewController = self
            banner.load(request)
            banner.delegate = self
        }

    }
    override func viewDidAppear(_ animated: Bool)
    {
        if UserDefaults.standard.value(forKey: "Coin") != nil
        {
            CoinLabel.text = " Coins: " + String(describing: UserDefaults.standard.value(forKey: "Coin")!)
        }
    }
    @IBAction func buttonSound(_ sender: Any)
    {
        SoundsEfect.instance.playSound(fileName: fileName.point.rawValue, fileExtension: fileExtension.wav.rawValue)
    }

}
extension MenuVC : GADBannerViewDelegate, GADRewardBasedVideoAdDelegate
{
    @IBAction func addCoin(_ sender: Any)
    {
        if GADRewardBasedVideoAd.sharedInstance().isReady == true {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
        }
    }
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didRewardUserWith reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        Player.instance.addCoin(coins: Int(truncating: reward.amount))
    }
}
