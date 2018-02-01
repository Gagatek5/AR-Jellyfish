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
    var NodesArray = ["art.scnassets/Jellyfish.scn", "art.scnassets/blue_Jellyfish.scn", "art.scnassets/green_Jellyfish.scn", "art.scnassets/bomb.scn" ]
    public func addNode(colour: Int)-> SCNNode {
        if colour <= 2
        {
        let jellyFishScene = SCNScene(named: NodesArray[colour])
        let jellyFishNode = jellyFishScene?.rootNode.childNode(withName: "Jellyfish", recursively: false)
        jellyFishNode?.position = SCNVector3(random.randomNumber(firstNum: -1, secondNum: 1), random.randomNumber(firstNum: -0.5, secondNum: 0.5), random.randomNumber(firstNum: -1, secondNum: 1))
            return jellyFishNode!
        } else //if colour == 3
        {
            let bombScene = SCNScene(named: NodesArray[colour])
            let bombNode = bombScene?.rootNode.childNode(withName: "Bomb", recursively: false)
            bombNode?.position = SCNVector3(random.randomNumber(firstNum: -1, secondNum: 1), random.randomNumber(firstNum: -0.5, secondNum: 0.5), random.randomNumber(firstNum: -1, secondNum: 1))
            return bombNode!
        }
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
