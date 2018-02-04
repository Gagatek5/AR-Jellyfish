//
//  SettingVC.swift
//  AR-Jellyfish
//
//  Created by Tom on 02/02/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {
    @IBOutlet weak var lblchecker: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func RemoveAds(_ sender: Any) {
        PurchaseManager.instance.purchaseRemoveAds { success in
            if success
            {
                self.lblchecker.text = "work"
            }
            else
            {
                self.lblchecker.text = "nope"
            }
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
