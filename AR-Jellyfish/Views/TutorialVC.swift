//
//  TutorialVC.swift
//  AR-Jellyfish
//
//  Created by Tom on 04/02/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import UIKit
import ARKit
import Each

class TutorialVC: UIViewController {
    
    @IBOutlet weak var tutorialSceneView: ARSCNView!
    @IBOutlet weak var tutorialTV: UITextView!
    
    let configuration = ARWorldTrackingConfiguration()
    
    var item = 0
    var countdown = 0
    var chapter = 0
    let tutorialText = ["Click on node to get point","Click on node to get 3 points","Click on node to get 5 points", "If you click on bomb, you lose the game", "You can collect coins to buy skins and power up", "clock give you more time ( 5 seconds )", "Congratulations. On game you must look around Click button to return to menu" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tutorialSceneView.session.run(configuration)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.tutorialSceneView.addGestureRecognizer(tapGestureRecognizer)
        addNodeToScene()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func buttonSound(_ sender: Any) {
        SoundsEfect.instance.playSound(fileName: fileName.point.rawValue, fileExtension: fileExtension.wav.rawValue)
    }
    func addNodeToScene() {
        
        
        switch chapter {
        case 0:
            item = 0
        case 1:
            item = 1
        case 2:
            item = 2
        case 3:
            item = 3
        case 4:
            item = 4
        case 5:
            item = 5
        default:
            item = 6
        }
        tutorialTV.text = tutorialText[item]
        //self.tutorialSceneView.scene.rootNode.addChildNode(nodeObject.addNode(colour: item + 6, generateBy: "Chapter"))
        if item != 6 {
            self.tutorialSceneView.scene.rootNode.addChildNode(NodeCreator.instance.addNode(colour: item, generateBy: "Target"))
        }
        
    }
    @objc func handleTap(sender: UITapGestureRecognizer)
    {
        let sceneViewTappedOn = sender.view as! SCNView
        let touchCoordinates = sender.location(in: sceneViewTappedOn)
        let hitTest = sceneViewTappedOn.hitTest(touchCoordinates)
        if !hitTest.isEmpty
        {
            let result = hitTest.first!
            let node = result.node
            
            if node.animationKeys.isEmpty
            {
                
                SCNTransaction.begin()
                NodeCreator.instance.animationNode(node: node)
                switch  chapter{
                case 0:
                    SoundsEfect.instance.playSound(fileName: fileName.point.rawValue, fileExtension: fileExtension.wav.rawValue)
                case 1:
                    SoundsEfect.instance.playSound(fileName: fileName.point.rawValue, fileExtension: fileExtension.wav.rawValue)
                case 2:
                    SoundsEfect.instance.playSound(fileName: fileName.point.rawValue, fileExtension: fileExtension.wav.rawValue)
                case 3:
                    SoundsEfect.instance.playSound(fileName: fileName.bomb2.rawValue, fileExtension: fileExtension.wav.rawValue)
                case 4:
                    SoundsEfect.instance.playSound(fileName: fileName.coin.rawValue, fileExtension: fileExtension.wav.rawValue)
                case 5:
                    SoundsEfect.instance.playSound(fileName: fileName.clock.rawValue, fileExtension: fileExtension.mp3.rawValue)
                default:
                    SoundsEfect.instance.playSound(fileName: fileName.point.rawValue, fileExtension: fileExtension.wav.rawValue)
                }
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                SCNTransaction.completionBlock = {
                    node.removeFromParentNode()
                    if self.chapter < 6 {
                        self.chapter += 1
                        self.addNodeToScene()
                    }
                }
                SCNTransaction.commit()
            }
        }
    }
    
    
}

