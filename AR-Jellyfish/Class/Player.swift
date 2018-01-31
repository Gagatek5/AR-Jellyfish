//
//  Player.swift
//  AR-Jellyfish
//
//  Created by Tom on 29/01/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import Foundation

class Player {
    let defaultsUserName = UserDefaults.standard
    
    public func SetNickName(nickName: String) {
         let defaultsUserName = UserDefaults.standard
        defaultsUserName.set(nickName, forKey: "UserName")
        
    }
}
