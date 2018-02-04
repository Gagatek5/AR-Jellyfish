//
//  SetNickNameVC.swift
//  AR-Jellyfish
//
//  Created by Tom on 31/01/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import UIKit

class SetNickNameVC: UIViewController {
    let defaultsUserName = UserDefaults.standard
    
    @IBOutlet weak var inputTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func setNickName(_ sender: Any) {
        defaultsUserName.set(inputTF.text, forKey: "UserName")
        //print(defaultsUserName.value(forKey: "UserName"))
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
