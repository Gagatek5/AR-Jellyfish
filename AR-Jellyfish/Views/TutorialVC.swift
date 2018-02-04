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

    var timer = Each(1).seconds
    @IBOutlet weak var tutorialSceneView: ARSCNView!
    @IBOutlet weak var tutorialTV: UITextView!
    
    let configuration = ARWorldTrackingConfiguration()
    
    var nodeObject = NodeCreator()
    let random = RandomNumberGenerator()
    var item = 0
    var countdown = 0
    var chapter = 0
    let tutorialText = ["Click on node to get point","Click on node to get 3 points","Click on node to get 5 points", "If you click on bomb, you lose the game", "You can collect coins to buy skins and power up", "clock give you more time ( 5 seconds )", "Congratulations. Tutorial END. Click button to return to menu" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tutorialSceneView.session.run(configuration)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.tutorialSceneView.addGestureRecognizer(tapGestureRecognizer)
        addNodeToScene()

        // Do any additional setup after loading the view.
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
        self.tutorialSceneView.scene.rootNode.addChildNode(nodeObject.addNode(colour: item, generateBy: "Target"))
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
                nodeObject.animationNode(node: node)
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
    func setTimer(){
        self.timer.perform { () -> NextStep in
            self.countdown -= 1
            
            if self.countdown <= 0
            {
                
                return .stop
            }
            return .continue
        }
    }
    func restartTimer() {

            self.countdown = 10
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
