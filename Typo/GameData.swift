//
//  GameData.swift
//  Typo
//
//  Created by Carl-Johan Svedin on 2014-07-07.
//  Copyright (c) 2014 Carl-Johan Svedin. All rights reserved.
//

import Foundation

class GameData {
    var level:Int
    var bossLevel :Bool
    let levelArray : NSArray
    
    init(){
        level=0
        bossLevel=false
        let path = NSBundle.mainBundle().pathForResource("Levels",ofType:"plist")
        levelArray = NSArray(contentsOfFile:path)

    }
    
    class var sharedInstance : GameData {
    struct Static {
        static let instance : GameData = GameData()
        }
   
        return Static.instance
    }
    
    func getLetters() -> String {
        let dict : NSDictionary = levelArray[level] as NSDictionary
        return dict.objectForKey("Characters") as String
    }    
}