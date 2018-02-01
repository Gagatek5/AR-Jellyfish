//
//  VARVC.swift
//  AR-Jellyfish
//
//  Created by Tom on 05/01/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import UIKit
import ARKit
import Each

class ARVC: UIViewController {

    

    var timer = Each(1).seconds
    var countdown = 10
    var points = 0
    var clicked = false
    
    //HighScores Label
    @IBOutlet weak var H1: UILabel!
    @IBOutlet weak var H2: UILabel!
    @IBOutlet weak var H3: UILabel!
    @IBOutlet weak var H4: UILabel!
    @IBOutlet weak var H5: UILabel!
    @IBOutlet weak var N1: UILabel!
    @IBOutlet weak var N2: UILabel!
    @IBOutlet weak var N3: UILabel!
    @IBOutlet weak var N4: UILabel!
    @IBOutlet weak var N5: UILabel!
    
    @IBOutlet weak var restart: UIButton!
    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    let checkScore = Highscore()
    let userName = Player()
    var nodeObject = NodeCreator()
    let random = RandomNumberGenerator()
    //let runGame = RunGame()
    var level = Level()
    var currentLevel = Level.level.one
    var colour = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        print( UserDefaults.standard.value(forKey: "UserName") as! String)
        checkScore.highscores(points: points, nickName: "none")
        self.menuView.isHidden = true
        self.restart.isEnabled = false
        self.sceneView.session.run(configuration)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        //let tapGestureRecognizer = runGame.createGesture()
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        loadHighScore()
        roundView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func roundView()
    {
        menuView.layer.cornerRadius = 20
    }



    @IBAction func play(_ sender: Any) {
        setTimer()
        self.addNodeToScene()
        self.play.isEnabled = false
        self.pointsLabel.isHidden = true
        self.menu.isEnabled = false
        self.menuView.isHidden = true
        self.restart.isEnabled = true
    }
    
    @IBAction func reset(_ sender: Any) {
         self.timer.stop()
        restartTimer()
        self.play.isEnabled = true
        points = 0
        self.currentLevel = self.level.SelectLevel(points: self.points)
        sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.pause()
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        self.pointsLabel.isHidden = true
        self.timerLabel.text = "Click play to start"
        self.menu.isEnabled = true
        
    }
    
    @IBAction func showMenu(_ sender: Any) {
        
        if clicked == true
        {
            self.menuView.isHidden = true
            self.pointsLabel.isHidden = false
            clicked = false
        } else
        {
            self.menuView.isHidden = false
            self.pointsLabel.isHidden = true
            loadHighScore()
            clicked = true
        }
        
    }
    func loadHighScore(){
        var ListOfScore = checkScore.getScore()
        var listOfNickName = checkScore.getNickName()
        var labelArrayOfScore = [H1, H2, H3, H4, H5]
        var labelArrayOfNickName = [N1, N2, N3, N4, N5]
        for index in 0...4
        {
            labelArrayOfScore[index]?.text = String(ListOfScore[index]) as String
            labelArrayOfNickName[index]?.text = "\(index + 1). " +  listOfNickName[index]
        }
        
    }
    
    
    func addNodeToScene() {
        colour = random.randomColourNode()
        let bomb = random.randomCreateBombNode()
        self.sceneView.scene.rootNode.addChildNode(nodeObject.addNode(colour: colour))
        if bomb == 3
        {
          
            self.sceneView.scene.rootNode.addChildNode(nodeObject.addNode(colour: bomb))
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
            
            if node.name! == "Bomb"
            {
                countdown = 0
                points = 0
                
            }
            
            if countdown > 0{

                switch colour {
                case 0:
                    points += 1
                case 1:
                    points += 3
                case 2:
                    points += 5
                default:
                    points += 0
                }
                restartTimer()
                if node.animationKeys.isEmpty
                {
                    SCNTransaction.begin()
                    nodeObject.animationNode(node: node)
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    SCNTransaction.completionBlock = {
                        node.removeFromParentNode()
                        self.addNodeToScene()
                        self.currentLevel = self.level.SelectLevel(points: self.points)
                        self.restartTimer()
                    }
                    SCNTransaction.commit()
                }
            }
        }
    }
    func setTimer(){
        self.timer.perform { () -> NextStep in
            self.countdown -= 1
            self.timerLabel.text = "Time: " + String(self.countdown) + " Points: " + String(self.points)
            if self.countdown <= 0
            {
                self.timerLabel.text = String("You lose")
                self.pointsLabel.text = "Your score: " + String(self.points)
                self.pointsLabel.isHidden = false
                self.checkScore.highscores(points: self.points, nickName: UserDefaults.standard.value(forKey: "UserName") as! String)
                self.menu.isEnabled = true
                return .stop
            }
            return .continue
        }
    }
    func restartTimer() {
        
        switch currentLevel {
            case Level.level.one:
                self.countdown = 10
            case Level.level.two:
                self.countdown = 8
            case Level.level.three:
                self.countdown = 7
            case Level.level.four:
                self.countdown = 6
            case Level.level.five:
                self.countdown = 5
        }
    }

    
}

