//
//  NodeCreator.swift
//  AR-Jellyfish
//
//  Created by Tom on 30/01/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import Foundation
import ARKit
class NodeCreator {
    var random = RandomNumberGenerator()
    
   public func addNode()-> SCNNode {
        let jellyFishScene = SCNScene(named: "art.scnassets/Jellyfish.scn")
        let jellyFishNode = jellyFishScene?.rootNode.childNode(withName: "Jellyfish", recursively: false)
        jellyFishNode?.position = SCNVector3(random.randomNumber(firstNum: -1, secondNum: 1), random.randomNumber(firstNum: -0.5, secondNum: 0.5), random.randomNumber(firstNum: -1, secondNum: 1))
        
    return jellyFishNode!
    }
   public func animationNode(node: SCNNode){
        
        let spin = CABasicAnimation(keyPath: "position")
        spin.fromValue = node.presentation.position
        spin.toValue = SCNVector3(node.presentation.position.x - 0.2,node.presentation.position.y - 0.2,node.presentation.position.z - 0.2)
        spin.duration = 0.1
        spin.autoreverses = true
        spin.repeatCount =  5
        node.addAnimation(spin, forKey: "position")
    }
    
}
