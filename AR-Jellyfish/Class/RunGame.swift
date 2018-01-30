//
//  RunGame.swift
//  AR-Jellyfish
//
//  Created by Tom on 30/01/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import Foundation
import Each
import ARKit

class RunGame
{
//    weak var  responder : LblProtocol?
//    init(responder : LblProtocol) {
//        self.responder = responder
//    }
    
    var nodeObject = NodeCreator()
    var timer = Each(1).seconds
    var countdown = 10
    var points = 0
    
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    
//    public func createGesture() -> UITapGestureRecognizer {
//        let tapGestureRecognizer = UITapGestureRecognizer(target: ARVC.self, action: #selector(handleTap))
//        return tapGestureRecognizer
//    }
    
    public func addNodeToScene(sceneView: ARSCNView) {
        
        sceneView.scene.rootNode.addChildNode(nodeObject.addNode())
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer, scene: ARSCNView)
    {
        let sceneViewTappedOn = sender.view as! SCNView
        let touchCoordinates = sender.location(in: sceneViewTappedOn)
        let hitTest = sceneViewTappedOn.hitTest(touchCoordinates)
        if !hitTest.isEmpty
        {
            if countdown > 0{
                countdown = 10
                let result = hitTest.first!
                let node = result.node
                points += 1
                if node.animationKeys.isEmpty
                {
                    SCNTransaction.begin()
                    nodeObject.animationNode(node: node)
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    SCNTransaction.completionBlock = {
                        node.removeFromParentNode()
                        self.addNodeToScene(sceneView: scene)
                        self.restartTimer()
                    }
                    SCNTransaction.commit()
                }
            }
        }
    }
    
    func setTimer(){
        let arvc = ARVC()
        self.timer.perform { () -> NextStep in
            self.countdown -= 1
            arvc.ChangeLbl(text: String("Time: " + String(self.countdown) + " Points: " + String(self.points)))
            //responder.ChangeLbl(text: String("Time: " + String(self.countdown) + " Points: " + String(self.points)))
            //ARVC().timerLabel.text = "Time: " + String(self.countdown) + " Points: " + String(self.points)
            if self.countdown == 0
            {
                
                arvc.timerLabel.text = String("You lose")
                arvc.pointsLabel.text = "Your score: " + String(self.points)
                arvc.pointsLabel.isHidden = false
                arvc.checkScore.highscores(points: self.points, nickName: "Gagatek")
                arvc.menu.isEnabled = true
                return .stop
            }
            return .continue
        }
    }

   func restartTimer() {
       self.countdown = 10
   }
}
