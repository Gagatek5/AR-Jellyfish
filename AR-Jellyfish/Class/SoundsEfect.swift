//
//  SoundsEfect.swift
//  AR-Jellyfish
//
//  Created by Tom on 20/02/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import AVFoundation

class SoundsEfect
{
    private init() {}
    static let instance = SoundsEfect()
    
    var player: AVAudioPlayer?
    static var audioPlayers = [AVAudioPlayer]()
    static var approve = true
    
    public func playSound(fileName: String, fileExtension: String, loop: Bool? = false){
        //play if on setting (approve sounds can be play or loop is for music)
        if SoundsEfect.approve || loop!{
            
            let path = Bundle.main.path(forResource: fileName + fileExtension, ofType:nil)!
            let url = URL(fileURLWithPath: path)
            
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch {
            }
            if loop == true
            {
                player?.numberOfLoops = -1
            }
            SoundsEfect.audioPlayers.append(player!)
        }
    }
    
    public func stopAll(){
        for player in SoundsEfect.audioPlayers {
            player.stop()
        }
    }
}

