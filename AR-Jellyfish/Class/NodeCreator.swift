//
//  NodeCreator.swift
//  AR-Jellyfish
//
//  Created by Tom on 30/01/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import ARKit

enum modeCreator{
    case Target
    case Random
}

class NodeCreator {
    private init() {}
    static let instance = NodeCreator()
    
    public func addNode(node: NodeName?, generateBy: modeCreator )-> SCNNode? {
        if node == nil{
            return nil
        }
        let jellyFishScene = SCNScene(named: "art.scnassets/Nodes.scn")
        let jellyFishNode = jellyFishScene?.rootNode.childNode(withName: (node?.rawValue)! , recursively: false)
        if generateBy == .Random
        {
            jellyFishNode?.position = SCNVector3(RandomNumberGenerator.instance.randomNumber(firstNum: -1, secondNum: 1), RandomNumberGenerator.instance.randomNumber(firstNum: -0.5, secondNum: 0.5), RandomNumberGenerator.instance.randomNumber(firstNum: -1, secondNum: 1))
            return jellyFishNode!
            
        }
        else  if generateBy == .Target
        {
            jellyFishNode?.position = SCNVector3(0,0,-1.5)
            return jellyFishNode!
            
        }
        return nil
    }
        
    
   public func animationNode(node: SCNNode){
        
        let spin = CABasicAnimation(keyPath: "position")
        spin.fromValue = node.presentation.position
        spin.toValue = SCNVector3(node.presentation.position.x - 0.2,node.presentation.position.y - 0.2,node.presentation.position.z - 0.2)
        spin.duration = 0.1
        spin.autoreverses = true
        spin.repeatCount =  3
        node.addAnimation(spin, forKey: "position")
    }
    
}

