//
//  DeathScene.swift
//  Typo
//
//  Created by carl-johan.svedin on 2014-11-07.
//  Copyright (c) 2014 Carl-Johan Svedin. All rights reserved.
//

import SpriteKit

class WinnerScene:SKScene
{
    override func didMove(to view: SKView) {
        isPaused=true
        let keyboard = Keyboard(selectedKeys: GameData.sharedInstance.getLetters())
        let keyboardWidth = keyboard.calculateAccumulatedFrame().width
        
        keyboard.position = CGPoint(x:(self.frame.width/2)-(keyboardWidth/2),y:300)
        addChild(keyboard)

    }
    
    override func mouseDown(with theEvent: NSEvent) {
        changeView()
    }
    
    override func keyDown(with event: NSEvent)
    {
        changeView()
    }

    func changeView()
    {
        let reveal = SKTransition.fade(withDuration: 3)
        var nextScene:SKScene;
        if GameData.sharedInstance.isBossLevel() {
            nextScene = MonsterScene(size:self.frame.size)
        }else{
            nextScene = SpaceScene(size: self.frame.size)
        }
        nextScene.scaleMode = SKSceneScaleMode.aspectFill;

        self.view!.presentScene(nextScene, transition: reveal)
    }
    
    override func willMove(from view: SKView) {
        view.isPaused=false
    }

}
