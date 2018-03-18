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
import GoogleMobileAds
import AVFoundation

class ARVC: UIViewController, GADInterstitialDelegate {
    
    //sounds
    let soundFile = SoundFile()
    let sound = SoundsEfect()
    let soundBomb = SoundsEfect()

    var player: AVAudioPlayer?
    //timer
    var timer = Each(1).seconds
    var countdown = 10
    var points = 0
    var clicked = false
    //Ad
    var interstitial: GADInterstitial!
    //HighScores Label
    @IBOutlet weak var H1: UILabel!
    @IBOutlet weak var H2: UILabel!
    @IBOutlet weak var H3: UILabel!
    @IBOutlet weak var H4: UILabel!
    @IBOutlet weak var H5: UILabel!
    //NickName Label
    @IBOutlet weak var N1: UILabel!
    @IBOutlet weak var N2: UILabel!
    @IBOutlet weak var N3: UILabel!
    @IBOutlet weak var N4: UILabel!
    @IBOutlet weak var N5: UILabel!
    //Butons
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var restart: UIButton!
    @IBOutlet weak var menu: UIButton!
    // View
    @IBOutlet weak var menuView: UIView!
    // Labels
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    //AR View
    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    let checkScore = Highscore()
    let playerStats = Player()
    var nodeObject = NodeCreator()
    let random = RandomNumberGenerator()
    
    //let runGame = RunGame()
    var level = Level()
    var currentLevel = Level.level.one
    var colour = 0
    var coin = 0
    var ad = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = GADRequest()
        request.testDevices = ["e098db6da62dd89b815fbb21837caeeb"]
        checkScore.highscores(points: points, nickName: "none")
        self.menuView.isHidden = true
        self.restart.isEnabled = false
        self.sceneView.session.run(configuration)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        //let tapGestureRecognizer = runGame.createGesture()
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        loadHighScore()
        roundView()
        interstitial = createAndLoadInterstitial()
        //interstitial.delegate = self
    }
    @IBAction func buttonSound(_ sender: Any) {
        sound.playSound(fileName: soundFile.FileName(fileNumber: 4), fileExtension: soundFile.FileExtension(fileNumber: 1))
    }
    func createAndLoadInterstitial() -> GADInterstitial {
        
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-5264924694211893/5195398237")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
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
        self.menu.isEnabled = true // wygląd przycisku
        
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
        let coin = random.randomCreateCoinNode()
        let clock = random.randomCreateClockNode()
        self.sceneView.scene.rootNode.addChildNode(nodeObject.addNode(colour: colour, generateBy: "Random"))
        if bomb == 3{
            self.sceneView.scene.rootNode.addChildNode(nodeObject.addNode(colour: bomb, generateBy: "Random"))
        }
        if coin == 4{
            self.sceneView.scene.rootNode.addChildNode(nodeObject.addNode(colour: coin, generateBy: "Random"))
        }
        if clock == 5{
            self.sceneView.scene.rootNode.addChildNode(nodeObject.addNode(colour: clock, generateBy: "Random"))
        }
        
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer)
    {
        let tabel = nodeObject.nodesChildArray
        let sceneViewTappedOn = sender.view as! SCNView
        let touchCoordinates = sender.location(in: sceneViewTappedOn)
        let hitTest = sceneViewTappedOn.hitTest(touchCoordinates)
        if !hitTest.isEmpty
        {
            let result = hitTest.first!
            let node = result.node
            
            if node.name! == "Bomb"
            {
                soundBomb.playSound(fileName: soundFile.FileName(fileNumber: 1), fileExtension: soundFile.FileExtension(fileNumber: 1))
                countdown = 0
                points = 0
                
            }
            
            
            if countdown > 0{
                
                switch  node.name! {
                case tabel[0]:
                    sound.playSound(fileName: soundFile.FileName(fileNumber: 4), fileExtension: soundFile.FileExtension(fileNumber: 1))
                    points += 1
                case tabel[1]:
                    sound.playSound(fileName: soundFile.FileName(fileNumber: 4), fileExtension: soundFile.FileExtension(fileNumber: 1))
                    points += 3
                case tabel[2]:
                    sound.playSound(fileName: soundFile.FileName(fileNumber: 4), fileExtension: soundFile.FileExtension(fileNumber: 1))
                    points += 5
                case tabel[4]:
                    sound.playSound(fileName: soundFile.FileName(fileNumber: 6), fileExtension: soundFile.FileExtension(fileNumber: 1))
                    coin += 1
                case tabel[5]:
                    sound.playSound(fileName: soundFile.FileName(fileNumber: 5), fileExtension: soundFile.FileExtension(fileNumber: 1))
                    countdown += 5
                default:
                    points += 0
                }
                
                if node.animationKeys.isEmpty
                {
                    for index in 0...5
                    {
                        if node.name! == tabel[index] && countdown == 1
                        {
                            self.countdown += 1
                        }
                        
                    }
                    
                    
                    SCNTransaction.begin()
                    nodeObject.animationNode(node: node)
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    SCNTransaction.completionBlock = {
                        node.removeFromParentNode()
                        
                        for index in 0...2
                        {
                            if node.name! == tabel[index]
                            {
                                
                                self.addNodeToScene()
                                self.currentLevel = self.level.SelectLevel(points: self.points)
                                self.restartTimer()
                            }
                        }
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
                self.sound.playSound(fileName: self.soundFile.FileName(fileNumber: 7), fileExtension: self.soundFile.FileExtension(fileNumber: 1))
                self.timerLabel.text = String("You lose")
                self.pointsLabel.text = "Your score: " + String(self.points)
                self.pointsLabel.isHidden = false
                self.checkScore.highscores(points: self.points, nickName: UserDefaults.standard.value(forKey: "UserName") as! String)
                self.menu.isEnabled = true
                if UserDefaults.standard.bool(forKey: PurchaseManager.instance.IAP_REMOVE_ADS) == false
                {
                    self.showAdd()
                }
                self.playerStats.updateCoin(coins: self.coin)
                self.coin = 0
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
    func showAdd(){

        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } 
    }
}

