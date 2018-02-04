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
        CoinLabel.text = " Coins: " + String(describing: UserDefaults.standard.value(forKey: "Coin")!)
        if UserDefaults.standard.bool(forKey: PurchaseManager.instance.IAP_REMOVE_ADS)
        {
            banner.removeFromSuperview()
        }else {
            
            let request: GADRequest = GADRequest()
            request.testDevices = ["5277be392040579b544c253892ea4bb1"]
            banner.adUnitID = "ca-app-pub-5264924694211893/7256152038"
            //"ca-app-pub-3940256099942544/2934735716"//"ca-app-pub-5264924694211893/7256152038"
            banner.rootViewController = self
            banner.load(request)
            banner.delegate = self
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    /// Tells the delegate an ad request loaded an ad.
//    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
//        print("adViewDidReceiveAd")
//    }
//
//    /// Tells the delegate an ad request failed.
//    func adView(_ bannerView: GADBannerView,
//                didFailToReceiveAdWithError error: GADRequestError) {
//        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
//    }
//
//    /// Tells the delegate that a full-screen view will be presented in response
//    /// to the user clicking on an ad.
//    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
//        print("adViewWillPresentScreen")
//    }
//
//    /// Tells the delegate that the full-screen view will be dismissed.
//    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
//        print("adViewWillDismissScreen")
//    }
//
//    /// Tells the delegate that the full-screen view has been dismissed.
//    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
//        print("adViewDidDismissScreen")
//    }
//
//    /// Tells the delegate that a user click will open another app (such as
//    /// the App Store), backgrounding the current app.
//    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
//        print("adViewWillLeaveApplication")
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
