//
//  SoundFile.swift
//  AR-Jellyfish
//
//  Created by Tom on 20/02/2018.
//  Copyright © 2018 Tom. All rights reserved.
//


import Foundation
class SoundFile
{
    
    var fileExtension = [ ".mp3", ".wav"]
    var fileName = [ "background", "bomb2", "boom", "buttonSound", "point", "clock", "coin", "gameEnd"]
    
    /**
     *A description field*
     - important: This is
     fileNumber:
     0-background,
     1-bomb2,
     2-boom,
     3-buttonSound,
     4-point,
     5-clock,
     6-coin,
     7-gameEnd,
     
     fileExtension:
     0-mp3,
     1-wav,
    
     - version: 1.0
     */
    public func FileName(fileNumber: Int) -> String
    {
        return fileName[fileNumber]
    }
    public func FileExtension(fileNumber: Int) -> String
    {
        return fileExtension[fileNumber]
    }
//
//    enum file {
//        case background
//        case boom
//        case bomb2
//        case buttonSound
//        case buttonSound2
//        case clock
//        case coin
//        case gameEnd
//    }
//    public func SelectFile(fileNumber: Int) -> file
//    {
//        switch fileNumber {
//        case 1:
//            return file.background
//        case 2:
//            return file.boom
//        case 3:
//            return file.bomb2
//        case 4:
//            return file.buttonSound
//        case 5:
//            return file.buttonSound2
//        case 6:
//            return file.clock
//        case 7:
//            return file.coin
//        case 8:
//            return file.gameEnd
//        default:
//            return file.background
//        }
//    }
    
}
