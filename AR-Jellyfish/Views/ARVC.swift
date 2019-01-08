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
    var player: AVAudioPlayer?
    //timer
    var timer = Each(1).seconds
    var countdown = 10 + (UserDefaults.standard.value(forKey: UserDefaultsString.timeMultiply.rawValue) as? Int)!
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
    @IBOutlet weak var bombRemover: UIButton!
    // View
    @IBOutlet weak var menuView: UIView!
    // Labels
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    //AR View
    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    let checkScore = Highscore()

    //let runGame = RunGame()
    var level = Level()
    var currentLevel = Level.level.one
    var colour = 0
    var coin = 0
    var ad = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkScore.highscores(points: points, nickName: "none")
        self.menuView.isHidden = true
        self.restart.isEnabled = false
        self.sceneView.session.run(configuration)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        loadHighScore()
        roundView()
        //self.bombRemover.titleLabel?.text = "Bomb remover \()"
        interstitial = createAndLoadInterstitial()
    }
    @IBAction func buttonSound(_ sender: Any) {
        SoundsEfect.instance.playSound(fileName: fileName.point.rawValue, fileExtension: fileExtension.wav.rawValue)
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
    func roundView()
    {
        menuView.layer.cornerRadius = 20
    }
    @IBAction func play(_ sender: Any) {
        setTimer()
        addAll()
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
    @objc func handleTap(sender: UITapGestureRecognizer)
    {
        let sceneViewTappedOn = sender.view as! SCNView
        let touchCoordinates = sender.location(in: sceneViewTappedOn)
        let hitTest = sceneViewTappedOn.hitTest(touchCoordinates)
        if !hitTest.isEmpty
        {
            let result = hitTest.first!
            let node = result.node
            
            if node.name! == NodeName.bomb.rawValue
            {
                countdown = 0
                points = 0
            }
            if countdown > 0{
                Node.instance.Sound(type: node.name!)
                switch  node.name! {
                case NodeName.fish.rawValue:
                    points += (1 * (UserDefaults.standard.value(forKey: UserDefaultsString.score.rawValue) as? Int)!)
                    var a = UserDefaults.standard.value(forKey: UserDefaultsString.payment.rawValue)! as! Array<Int>
                    print((1 * a[0]))
                case NodeName.fishRed.rawValue:
                    points += (3 * (UserDefaults.standard.value(forKey: UserDefaultsString.score.rawValue) as? Int)!)
                case NodeName.fishBlue.rawValue:
                    points += (5 * (UserDefaults.standard.value(forKey: UserDefaultsString.score.rawValue) as? Int)!)
                case NodeName.coin.rawValue:
                    coin += (1 * (UserDefaults.standard.value(forKey: UserDefaultsString.coinMultiply.rawValue) as? Int)!)
                case NodeName.clock.rawValue:
                    countdown += (5 + (UserDefaults.standard.value(forKey: UserDefaultsString.timeMultiply.rawValue) as? Int)!)
                default:
                    points += 0
                }
                if node.animationKeys.isEmpty
                {
                    if countdown == 1
                    {
                        self.countdown += 1
                    }
                    SCNTransaction.begin()
                    NodeCreator.instance.animationNode(node: node)
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    SCNTransaction.completionBlock = {
                        node.removeFromParentNode()
                        
                        for index in 0...2
                        {
                            if node.name! == NodeName.allNode[index].rawValue
                            {
                                self.addAll()
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
    func addAll(){
        let list = [Node.instance.addNodeToScene(node: .fish, generateBy: .Random ), Node.instance.addNodeToScene(node: .bomb, generateBy: .Random), Node.instance.addNodeToScene(node: .coin, generateBy: .Random), Node.instance.addNodeToScene(node: .clock, generateBy: .Random)]
        for index in list
        {
            if index != nil{
                self.sceneView.scene.rootNode.addChildNode(index!)
            }
        }
    }
    
    @IBAction func removeBombButton(_ sender: Any) {
        if (UserDefaults.standard.value(forKey: UserDefaultsString.bombRemover.rawValue) as? Int)! > 0
        {
            sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                if (node.name == NodeName.bomb.rawValue)
                {
                    node.removeFromParentNode()
                }
            }
            Player.instance.updateBombRemover(false)
        }
    }
    func setTimer(){
        self.timer.perform { () -> NextStep in
            self.countdown -= 1
            self.timerLabel.text = "Time: " + String(self.countdown) + " Points: " + String(self.points)
            if self.countdown <= 0
            {
                SoundsEfect.instance.playSound(fileName: fileName.gameEnd.rawValue, fileExtension: fileExtension.wav.rawValue)
                self.timerLabel.text = String("You lose")
                self.pointsLabel.text = "Your score: " + String(self.points)
                self.pointsLabel.isHidden = false
                self.checkScore.highscores(points: self.points, nickName: UserDefaults.standard.value(forKey: UserDefaultsString.userName.rawValue) as! String)
                self.menu.isEnabled = true
                if UserDefaults.standard.bool(forKey: PurchaseManager.instance.IAP_REMOVE_ADS) == false
                {
                    self.showAdd()
                }
                Player.instance.addCoin(coins: self.coin)
                self.coin = 0
                return .stop
            }
            return .continue
        }
    }
    func restartTimer() {
        switch currentLevel {
        case Level.level.one:
            self.countdown = 10 + (UserDefaults.standard.value(forKey: UserDefaultsString.timeMultiply.rawValue) as? Int)!
        case Level.level.two:
            self.countdown = 8 + (UserDefaults.standard.value(forKey: UserDefaultsString.timeMultiply.rawValue) as? Int)!
        case Level.level.three:
            self.countdown = 7 + (UserDefaults.standard.value(forKey: UserDefaultsString.timeMultiply.rawValue) as? Int)!
        case Level.level.four:
            self.countdown = 6 + (UserDefaults.standard.value(forKey: UserDefaultsString.timeMultiply.rawValue) as? Int)!
        case Level.level.five:
            self.countdown = 5 + (UserDefaults.standard.value(forKey: UserDefaultsString.timeMultiply.rawValue) as? Int)!
        }
    }
    func showAdd(){
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        }
    }
}
