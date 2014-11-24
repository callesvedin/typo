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
    override func didMoveToView(view: SKView) {
        paused=true
        let keyboard = Keyboard(selectedKeys: GameData.sharedInstance.getLetters())
        let keyboardWidth = keyboard.calculateAccumulatedFrame().width
        
        keyboard.position = CGPoint(x:(self.frame.width/2)-(keyboardWidth/2),y:300)
        addChild(keyboard)

    }
    
    override func mouseDown(theEvent: NSEvent) {
        changeView()
    }
    
    override func keyDown(event: NSEvent)
    {
        changeView()
    }

    func changeView()
    {
        let reveal = SKTransition.fadeWithDuration(3)
        let spaceScene = SpaceScene(size: self.frame.size)
        spaceScene.scaleMode = SKSceneScaleMode.AspectFill;
        GameData.sharedInstance.increaseLevel()
        self.view!.presentScene(spaceScene, transition: reveal)
    }
    
    override func willMoveFromView(view: SKView) {
        view.paused=false
    }

}
