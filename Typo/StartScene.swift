//
//  StartScene.swift
//  Typo
//
//  Created by carl-johan.svedin on 2014-11-03.
//  Copyright (c) 2014 Carl-Johan Svedin. All rights reserved.
//

import SpriteKit

class StartScene: SKScene {
    
    
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
        let spaceScene = SpaceScene(size: self.frame.size)
        spaceScene.scaleMode = SKSceneScaleMode.aspectFill;

        self.view!.presentScene(spaceScene, transition: reveal)
    }

    
    override func willMove(from view: SKView) {
        view.isPaused=false
    }
}

    
