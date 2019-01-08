//
//  Level.swift
//  AR-Jellyfish
//
//  Created by Tom on 30/01/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import Foundation

class Level {
    
    enum level {
        case one
        case two
        case three
        case four
        case five
    }
    
    public func SelectLevel(points: Int) -> level
    {
        switch points {
        case 0...40:
            return level.one
        case 41...80:
            return level.two
        case 81...150:
            return level.three
        case 151...300:
            return level.four
        default:
            return level.five
        }
    }
}
