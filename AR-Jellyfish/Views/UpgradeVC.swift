//
//  UpgradeVC.swift
//  AR-Jellyfish
//
//  Created by Tom on 31/03/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import UIKit

class UpgradeVC: UIViewController {
    
    
    @IBOutlet weak var scorePriceL: UILabel!
    @IBOutlet weak var extraSecondPriceL: UILabel!
    @IBOutlet weak var coinMultiPriceL: UILabel!
    @IBOutlet weak var bombRemoverPriceL: UILabel!
    
    @IBOutlet weak var scoreL: UILabel!
    @IBOutlet weak var timeL: UILabel!
    @IBOutlet weak var coinL: UILabel!
    @IBOutlet weak var bombRemoverL: UILabel!
    
    var payment = UserDefaults.standard.value(forKey: UserDefaultsString.payment.rawValue) as? Array<Int>
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        refreshview()
    }
    func refreshview()
    {
        payment = UserDefaults.standard.value(forKey: UserDefaultsString.payment.rawValue) as? Array<Int>
        scoreL.text = "Score: x\(String(describing: UserDefaults.standard.value(forKey: UserDefaultsString.score.rawValue)!))"
        timeL.text = "Extra time: +\(String(describing: UserDefaults.standard.value(forKey: UserDefaultsString.timeMultiply.rawValue)!))s"
        coinL.text = "Coin: x\(String(describing: UserDefaults.standard.value(forKey: UserDefaultsString.coinMultiply.rawValue)!))"
        bombRemoverL.text = "Bomb Remover: \(String(describing: UserDefaults.standard.value(forKey: UserDefaultsString.bombRemover.rawValue)!))"
        scorePriceL.text = "\(10 * payment![0])$"
        extraSecondPriceL.text = "\(25 * payment![1])$"
        coinMultiPriceL.text = "\(10 * payment![2])$"
    }
    @IBAction func upgradeScore(_ sender: Any) {
        if Player.instance.payCoin(pay: 10 * payment![Upgrade.Score.rawValue]){
            Player.instance.updateScoreMultiplire()
            Player.instance.paymentLevel(upgrade: .Score)
            refreshview()
        }
    }
    @IBAction func upgradeTime(_ sender: Any) {
        if Player.instance.payCoin(pay: 25 * payment![Upgrade.Time.rawValue]){
            Player.instance.updateExtraSecond()
            Player.instance.paymentLevel(upgrade: .Time)
            refreshview()
        }
    }
    @IBAction func upgradeCoin(_ sender: Any) {
        if Player.instance.payCoin(pay: 10 * payment![Upgrade.Coin.rawValue]){
            Player.instance.updateCoinMultiplire()
            Player.instance.paymentLevel(upgrade: .Coin)
            refreshview()
        }
    }
    @IBAction func addBombRemover(_ sender: Any) {
        if Player.instance.payCoin(pay: 30){
            Player.instance.updateBombRemover(true)
            refreshview()
        }
    }
    @IBAction func buttonSound(_ sender: Any) {
        
        SoundsEfect.instance.playSound(fileName: fileName.point.rawValue, fileExtension: fileExtension.wav.rawValue)
    }
    
    
}
