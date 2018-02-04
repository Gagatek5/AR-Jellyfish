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
        case 0...20:
            return level.one
        case 21...35:
            return level.two
        case 36...50:
            return level.three
        case 51...80:
            return level.four
        default:
            return level.five
        }
}
}
