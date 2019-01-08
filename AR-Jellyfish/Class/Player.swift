//
//  Player.swift
//  AR-Jellyfish
//
//  Created by Tom on 29/01/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import Foundation

enum UserDefaultsString:String
{
    case coin = "Coin"
    case score = "scoreMultiplier"
    case coinMultiply = "coinMultiplier"
    case timeMultiply = "extrasecond"
    case bombRemover = "bombRemover"
    case payment = "Payment"
    case nick = "SetNick"
    case userName = "UserName"
}



class Player {
    
    private init() {}
    static let instance = Player()
    
    var coin = 0

    public func addCoin(coins: Int) {
        if UserDefaults.standard.value(forKey: UserDefaultsString.coin.rawValue) != nil
        {
             coin = UserDefaults.standard.value(forKey: UserDefaultsString.coin.rawValue)! as! Int
        }
       UserDefaults.standard.set((coin + coins), forKey: UserDefaultsString.coin.rawValue)
    }
    public func payCoin(pay: Int) -> Bool {
        if pay < UserDefaults.standard.value(forKey: UserDefaultsString.coin.rawValue)! as! Int
        {
            UserDefaults.standard.set(((UserDefaults.standard.value(forKey: UserDefaultsString.coin.rawValue)! as! Int) - pay), forKey: UserDefaultsString.coin.rawValue)
            return true
        }else {
            return false
        }
        
    }
    public func updateScoreMultiplire() {
        var scoreMultiplier = 1
        if UserDefaults.standard.value(forKey: UserDefaultsString.score.rawValue) != nil
        {
            scoreMultiplier = UserDefaults.standard.value(forKey: UserDefaultsString.score.rawValue)! as! Int
            print(scoreMultiplier)
        }
       UserDefaults.standard.set((scoreMultiplier * 2), forKey: UserDefaultsString.score.rawValue)
        
    }
    public func updateCoinMultiplire() {
        var coinMultiplier = 1
        if UserDefaults.standard.value(forKey: UserDefaultsString.coinMultiply.rawValue) != nil
        {
            coinMultiplier = UserDefaults.standard.value(forKey: UserDefaultsString.coinMultiply.rawValue)! as! Int
            print(coinMultiplier)
        }
        UserDefaults.standard.set((coinMultiplier + 1), forKey: UserDefaultsString.coinMultiply.rawValue)
    }
    public func updateExtraSecond() {
        var extrasecond = 0
        if UserDefaults.standard.value(forKey: UserDefaultsString.timeMultiply.rawValue) != nil
        {
            extrasecond = UserDefaults.standard.value(forKey: UserDefaultsString.timeMultiply.rawValue)! as! Int
            print("time:\(extrasecond)")
        }
        UserDefaults.standard.set((extrasecond + 1), forKey: UserDefaultsString.timeMultiply.rawValue)
    }
    public func updateBombRemover(_ operation: Bool) {
        var bombRemover = 0
        if UserDefaults.standard.value(forKey: UserDefaultsString.bombRemover.rawValue) != nil
        {
            bombRemover = UserDefaults.standard.value(forKey: UserDefaultsString.bombRemover.rawValue)! as! Int
            print(bombRemover)
        }
        if operation == true
        {
            UserDefaults.standard.set((bombRemover + 1), forKey: UserDefaultsString.bombRemover.rawValue)
        } else if operation == false
        {
            UserDefaults.standard.set((bombRemover - 1), forKey: UserDefaultsString.bombRemover.rawValue)
        }
    }
    func paymentLevel(upgrade: Upgrade){
        var levelList = UserDefaults.standard.value(forKey: UserDefaultsString.payment.rawValue) as? Array<Int>
        if upgrade == .Score || upgrade == .Time
        {
            levelList![upgrade.rawValue] += 2
        } else {
            levelList![upgrade.rawValue] += 3
        }
        
        UserDefaults.standard.set(levelList, forKey: UserDefaultsString.payment.rawValue)
        print(UserDefaults.standard.value(forKey: UserDefaultsString.payment.rawValue)!)
    }
    func paymentLevelList(){
        if UserDefaults.standard.value(forKey: UserDefaultsString.payment.rawValue) == nil
        {
            let paymentLevelList = [1, 1, 1]
            UserDefaults.standard.set(paymentLevelList, forKey: UserDefaultsString.payment.rawValue)
        }
        
    }
}
enum Upgrade: Int{
    case Score = 0
    case Time = 1
    case Coin = 2
}
