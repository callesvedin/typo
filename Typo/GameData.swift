//
//  GameData.swift
//  Typo
//
//  Created by Carl-Johan Svedin on 2014-07-07.
//  Copyright (c) 2014 Carl-Johan Svedin. All rights reserved.
//

import Foundation

class GameData: CJCrashDelegate, CJHitDelegate {
    var level:Int
    var bossLevel :Bool
    var progressChangeListener:CJProgressListenerProtocol?
    
    let levelArray : NSArray
    
    var progress:CGFloat{
        didSet {
            if let progressListener = progressChangeListener {
                progressChangeListener?.progressChanged(newValue:progress)
                println("Progress changed to:\(progress)")
            }            
        }
    }
    
    init(){
        level=0
        bossLevel=false
        let path = NSBundle.mainBundle().pathForResource("Levels",ofType:"plist")
        levelArray = NSArray(contentsOfFile:path!)!
        progress=0.5
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
    
    func didCrash(letter: Character){
        progress-=0.1
    }
    
    func didHit(letter: Character){
        progress+=0.05
    }

}