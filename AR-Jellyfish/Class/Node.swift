//
//  Node.swift
//  AR-Jellyfish
//
//  Created by Tom on 28/03/2018.
//  Copyright © 2018 Tom. All rights reserved.
//


import ARKit

enum NodeName{
    case fish
    case coin
    case bomb
    case clock
}

class Node{
    private init() {}
    static let instance = Node()
    func Sound(type: NodeName){
        switch type {
        case .coin:
            SoundsEfect.instance.playSound(fileName: fileName.coin.rawValue, fileExtension: fileExtension.wav.rawValue)
        case .clock:
            SoundsEfect.instance.playSound(fileName: fileName.clock.rawValue, fileExtension: fileExtension.mp3.rawValue)
        case .bomb:
            SoundsEfect.instance.playSound(fileName: fileName.bomb2.rawValue, fileExtension: fileExtension.wav.rawValue)
        default:
            SoundsEfect.instance.playSound(fileName: fileName.point.rawValue, fileExtension: fileExtension.wav.rawValue)
        }
        
    }
    func addNodeToScene() -> SCNNode {
        if RandomNumberGenerator.instance.randomNode(type: NodeName.fish, maxPercent: 10) <= 2 {
            return NodeCreator.instance.addNode(colour: RandomNumberGenerator.instance.randomNode(type: NodeName.fish, maxPercent: 10), generateBy: "Random")
        }
        if RandomNumberGenerator.instance.randomNode(type: NodeName.bomb, maxPercent: 4) == 3{
            return NodeCreator.instance.addNode(colour: 3, generateBy: "Random")
        }
        if RandomNumberGenerator.instance.randomNode(type: NodeName.coin, maxPercent: 10) == 4{
            return NodeCreator.instance.addNode(colour: 4, generateBy: "Random")
        }
        if RandomNumberGenerator.instance.randomNode(type: NodeName.clock, maxPercent: 3) == 5{
            return NodeCreator.instance.addNode(colour: 5, generateBy: "Random")
        }
        return NodeCreator.instance.addNode(colour: 5, generateBy: "Random")
    }
   
}
