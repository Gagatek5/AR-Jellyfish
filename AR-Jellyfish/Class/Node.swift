//
//  Node.swift
//  AR-Jellyfish
//
//  Created by Tom on 28/03/2018.
//  Copyright © 2018 Tom. All rights reserved.
//


import ARKit

enum NodeName: String{
    case fish = "GreenFish"
    case fishBlue = "BlueFish"
    case fishRed = "RedFish"
    case coin = "Coin"
    case bomb = "Bomb"
    case clock = "Clock"
    case empty = ""
    
    static let allNode = [fish, fishRed, fishBlue, coin, bomb, clock]
}

class Node{
    private init() {}
    static let instance = Node()
    func Sound(type: NodeName.RawValue){
        switch type {
        case NodeName.coin.rawValue :
            SoundsEfect.instance.playSound(fileName: fileName.coin.rawValue, fileExtension: fileExtension.wav.rawValue)
        case NodeName.clock.rawValue:
            SoundsEfect.instance.playSound(fileName: fileName.clock.rawValue, fileExtension: fileExtension.mp3.rawValue)
        case NodeName.bomb.rawValue:
            SoundsEfect.instance.playSound(fileName: fileName.bomb2.rawValue, fileExtension: fileExtension.wav.rawValue)
        default:
            SoundsEfect.instance.playSound(fileName: fileName.point.rawValue, fileExtension: fileExtension.wav.rawValue)
        }
        
    }
    func addNodeToScene(node: NodeName, generateBy: modeCreator) -> SCNNode? {
        if generateBy == .Random{
            switch node {
            case .fish, .fishBlue, .fishRed, .empty:
                return NodeCreator.instance.addNode(node: RandomNumberGenerator.instance.randomNode(type: node, maxPercent: 10), generateBy: generateBy)
            case .bomb, .coin, .clock:
                return NodeCreator.instance.addNode(node: RandomNumberGenerator.instance.randomNode(type: node, maxPercent: 4), generateBy: generateBy)
            }
        }else {
            switch node {
            case .fish, .fishBlue, .fishRed, .empty:
                return NodeCreator.instance.addNode(node: node, generateBy: generateBy)
            case .bomb, .coin, .clock:
                return NodeCreator.instance.addNode(node:node, generateBy: generateBy)
            }
        }
    }
}
