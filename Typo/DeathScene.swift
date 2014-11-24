//
//  DeathScene.swift
//  Typo
//
//  Created by carl-johan.svedin on 2014-11-07.
//  Copyright (c) 2014 Carl-Johan Svedin. All rights reserved.
//

import SpriteKit

class DeathScene:SKScene
{
    override func didMoveToView(view: SKView) {
        paused=true
    }
    
    override func mouseDown(theEvent: NSEvent) {
        /* Called when a mouse click occurs */
        
        if let scene = StartScene.unarchiveFromFile("StartScene") as? StartScene {
            let reveal = SKTransition.fadeWithDuration(3)
            scene.scaleMode = SKSceneScaleMode.AspectFill;
            self.view!.presentScene(scene, transition: reveal)
        }
            
        println("Game started")
    }
    
    override func willMoveFromView(view: SKView) {
        view.paused=false
    }

}
