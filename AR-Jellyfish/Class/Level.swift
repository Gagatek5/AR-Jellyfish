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
        case 0...5:
            return level.one
        case 6...10:
            return level.two
        case 11...20:
            return level.three
        case 21...30:
            return level.four
        case 31...50:
            return level.five
        default:
            return level.five
        }
}
}
