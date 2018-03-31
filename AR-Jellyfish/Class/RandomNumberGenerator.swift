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
    func randomNode(type: NodeName, maxPercent: Int) -> NodeName?{
        let percent = Int(arc4random_uniform(UInt32(maxPercent)))
        switch type {
        case .fish, .fishBlue, .fishRed:
            switch percent {
            case 7...9:
                return .fishRed
            case 0:
                return .fishBlue
            default:
                return .fish
            }
        case .bomb:
            if percent == 1
            {
                return .bomb
            }
        case .coin:
            if percent == 1
            {
                return .coin
            }
        case .clock:
            if percent == 1
            {
                return .clock
            }
        default:
            return nil
        }
        return nil
    }
}
