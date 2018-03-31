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
            tutorialTV.text = tutorialText[chapter]
            if chapter != 6 {
                self.tutorialSceneView.scene.rootNode.addChildNode(Node.instance.addNodeToScene(node: NodeName.allNode[chapter], generateBy: .Target)!)
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
                Node.instance.Sound(type: node.name!)
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

