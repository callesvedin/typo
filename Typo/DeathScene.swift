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
    override func didMove(to view: SKView) {
        isPaused=true
    }
    
    override func mouseDown(with theEvent: NSEvent) {
        /* Called when a mouse click occurs */
        
        if let scene = SKScene(fileNamed: "StartScene") {
//        if let scene = StartScene.unarchiveFromFile("StartScene") as? StartScene {
        
            let reveal = SKTransition.fade(withDuration: 3)
            scene.scaleMode = SKSceneScaleMode.aspectFill;
            self.view!.presentScene(scene, transition: reveal)
        }
            
        print("Game started")
    }
    
    override func willMove(from view: SKView) {
        view.isPaused=false
    }

}
