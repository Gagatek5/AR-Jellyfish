//
//  ColourNode.swift
//  AR-Jellyfish
//
//  Created by Tom on 04/02/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import Foundation

class ColourNode {
    
    func ItemCreator(item: Int) -> Int {
        
       
        switch item {
        case 5:
            return 1
        case 76...100:
            return 2
        default:
            return 0
        }
    }
}
