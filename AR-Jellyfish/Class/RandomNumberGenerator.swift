//
//  RandomNumberGenerator.swift
//  AR-Jellyfish
//
//  Created by Tom on 30/01/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import UIKit

class RandomNumberGenerator {
    private init() {}
    static let instance = RandomNumberGenerator()
    func randomNumber(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    func randomNode(type: NodeName, maxPercent: Int) -> Int{
        
        let percent = Int(arc4random_uniform(UInt32(maxPercent)))
        switch type {
        case .fish:
            switch percent {
            case 7...9:
                return 1
            case 10:
                return 2
            default:
                return 0
            }
        case .bomb:
            switch percent {
            case 1:
                return 3
            default:
                return 0
            }
        case .coin:
            switch percent {
            case 1:
                return 4
            default:
                return 0
            }
        case .clock:
            switch percent {
            case 1:
                return 5
            default:
                return 0
            }
        }
    
    }
    func randomColourNode() -> Int
    {
        let percent = Int(arc4random_uniform(10))
        switch percent {
        case 7...9:
            return 1
        case 10:
            return 2
        default:
            return 0
        }
    }
    func randomCreateBombNode() -> Int
    {
        let percent = Int(arc4random_uniform(4))
        switch percent {
        case 1:
            return 3
        default:
            return 0
        }
        
    }
    func randomCreateCoinNode() -> Int
    {
        let percent = Int(arc4random_uniform(10))
        switch percent {
        case 1:
            return 4
        default:
            return 0
        }
        
    }
    func randomCreateClockNode() -> Int
    {
        let percent = Int(arc4random_uniform(3))
        switch percent {
        case 1:
            return 5
        default:
            return 0
        }
        
    }
}
