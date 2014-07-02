//
//  GameScene.swift
//  Typo
//
//  Created by Carl-Johan Svedin on 2014-06-06.
//  Copyright (c) 2014 Carl-Johan Svedin. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var _gamePaused = true
    var _initialized = false;
    var _previousTime = 0.0
    var _deltaTime = 0.0
    let pressToStartLabel = SKLabelNode(fontNamed:"Helvetica")

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.physicsWorld.gravity = CGVectorMake(0.0, -2.0);

        pressToStartLabel.text = "Tryck för att starta!";
        pressToStartLabel.fontSize = 65;
        pressToStartLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(pressToStartLabel)
        
    }
    
    override func mouseDown(theEvent: NSEvent) {
        /* Called when a mouse click occurs */
        
        let location = theEvent.locationInNode(self)
        _gamePaused = false
        pressToStartLabel.removeFromParent();
        println("Game started")
        
    }
    
    
}
