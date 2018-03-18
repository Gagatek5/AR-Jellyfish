//
//  Highscore.swift
//  AR-Jellyfish
//
//  Created by Tom on 28/01/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import Foundation

class Highscore{
    
    let defaultsPoints = UserDefaults.standard
    var highscores = [Int]()
    var nickNames = [String]()
    
    public func highscores(points: Int, nickName: String)
    {
        if (defaultsPoints.value(forKey: "HighScore") == nil)
        {
             highscores = [50, 30, 10, 5, 1]
             nickNames = ["Player1", "Player2", "Player3", "Player4", "Player5"]
        } else
        {
            highscores = (defaultsPoints.array(forKey: "HighScore") as? [Int])!
            nickNames = (defaultsPoints.array(forKey: "NickName") as? [String])!
            
        }

        for score in 0...4 {
            if points > highscores[score]
            {
                highscores.insert(points, at: score)
                highscores.removeLast()
                nickNames.insert(nickName, at: score)
                nickNames.removeLast()
                break
            }else if points == highscores[score]
            {
                highscores.insert(points, at: score + 1)
                highscores.removeLast()
                nickNames.insert(nickName, at: score + 1)
                nickNames.removeLast()
                break
            }
        }
        defaultsPoints.set(highscores, forKey: "HighScore")
        defaultsPoints.set(nickNames, forKey: "NickName")
        
    }
   public func getScore() -> [Int]
    {
        highscores = (defaultsPoints.array(forKey: "HighScore") as? [Int])!
        return highscores
    }
    public func getNickName() -> [String]
    {
        nickNames = (defaultsPoints.array(forKey: "NickName") as? [String])!
        return nickNames
    }

}
