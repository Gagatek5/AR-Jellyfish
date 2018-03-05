//
//  Player.swift
//  AR-Jellyfish
//
//  Created by Tom on 29/01/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import Foundation

class Player {
    
    public func updateCoin(coins: Int) {
        var oldStatusCoin: Int = 0
        if UserDefaults.standard.value(forKey: "Coin") != nil
        {
             oldStatusCoin = UserDefaults.standard.value(forKey: "Coin")! as! Int
        }
       UserDefaults.standard.set((oldStatusCoin + coins), forKey: "Coin")

        
    }
}
