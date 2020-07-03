//
//  GameData.swift
//  Typo
//
//  Created by Carl-Johan Svedin on 2014-07-07.
//  Copyright (c) 2014 Carl-Johan Svedin. All rights reserved.
//

import Foundation

class GameData: CJCrashDelegate, CJHitDelegate {
    let randomGenerator = RandomNumberGenerator()
    var level:Int
    var bossLevel :Bool
    var progressChangeListener:CJProgressListenerProtocol?
    var gameOverDelegate:GameOverDelegate?
    var userWonDelegate:UserWonDelegate?
    let levelArray : NSArray

    
    var progress:CGFloat{
        didSet {
                progressChangeListener?.progressChanged(newValue:progress)
                print("Progress changed to:\(progress)")
        }
    }
    
    init(){
        level=0
        bossLevel=false
        let path = Bundle.main.path(forResource: "Levels",ofType:"plist")
        levelArray = NSArray(contentsOfFile:path!)!
        progress=0.2
    }
    
    class var sharedInstance : GameData {
    struct Static {
        static let instance : GameData = GameData()
        }
   
        return Static.instance
    }
    
    func getDropRate() ->Double {
        let levelDictionary = getLevelDictionary()
        return (levelDictionary.object(forKey: "asteroidDropRate") as! Double)
    }
    
    func getRandomSpeed() -> CGFloat {
        let randomSpeed = randomGenerator.randomInt(1, to: 3)
        let levelDictionary = getLevelDictionary()
        return (levelDictionary.object(forKey: "asteroidSpeed_\(randomSpeed)") as! CGFloat)
    }
    
    func getLevelDictionary() -> NSDictionary
    {
        return levelArray[level] as! NSDictionary
    }
    
    func isBossLevel() -> Bool
    {
        let dict = getLevelDictionary()
        let levelTypeString = dict.object(forKey: "levelType") as! String
        if "BOSS" == levelTypeString{
            return true
        }
        return false
    }
    
    func getLetters() -> String {
        let dict = getLevelDictionary()
        return dict.object(forKey: "Characters") as! String
    }
    
    func didCrash(_ letter: Character){
        progress-=0.1
        if progress<0 {
            progress=0;
            gameOverDelegate?.userDied()
        }
    }
    
    func didHit(_ letter: Character){
        progress+=0.05
        if progress>1 {
            level += 1
            userWonDelegate?.userWon()
        }

    }

}
