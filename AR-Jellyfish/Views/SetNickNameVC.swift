//
//  SetNickNameVC.swift
//  AR-Jellyfish
//
//  Created by Tom on 31/01/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import UIKit
import AVFoundation

class SetNickNameVC: UIViewController, UITextFieldDelegate {
    
    let defaultsUserName = UserDefaults.standard
    var player: AVAudioPlayer?
    
    @IBOutlet weak var InfoL: UILabel!
    @IBOutlet weak var inputTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIScreen.main.bounds.size.height <= 568{
            InfoL.font = InfoL.font.withSize(45)
        } else if UIScreen.main.bounds.size.height <= 667
        {
            InfoL.font = InfoL.font.withSize(48)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setNickName(_ sender: Any) {

        SoundsEfect.instance.playSound(fileName: fileName.point.rawValue, fileExtension: fileExtension.wav.rawValue)
        defaultsUserName.set(inputTF.text, forKey: "UserName")
    }
 

}
