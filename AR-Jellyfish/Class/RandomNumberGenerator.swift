//
//  RandomNumberGenerator.swift
//  AR-Jellyfish
//
//  Created by Tom on 30/01/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import Foundation
import UIKit

class RandomNumberGenerator
{
    func randomNumber(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    func randomColourNode() -> Int
    {
        let percent = Int(arc4random_uniform(101))
        switch percent {
        case 51...75:
            return 1
        case 76...100:
            return 2
        default:
            return 0
        }
    }
    func randomCreateBombNode() -> Int
    {
        let percent = Int(arc4random_uniform(101))
        
        if percent > 75
        {
            return 3

        }
        else
        {
            return 0
        }
    }
}
