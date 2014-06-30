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
/*        let sprite = SKSpriteNode(imageNamed:"Spaceship")
        sprite.position = location;
        sprite.setScale(0.2)
        
        let action = SKAction.rotateByAngle(M_PI, duration:1)
        sprite.runAction(SKAction.repeatActionForever(action))
        
        self.addChild(sprite)*/
        
    }
    
    
}
