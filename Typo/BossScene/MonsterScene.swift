//
//  MonsterScene.swift
//  Typo
//
//  Created by Carl-Johan Svedin on 2014-06-08.
//  Copyright (c) 2014 Carl-Johan Svedin. All rights reserved.
//

import SpriteKit

class MonsterScene:SKScene {
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        print("Loaded monster scene")
        backgroundColor = NSColor(red: 0.3, green: 0.3, blue: 0.9, alpha: 1)
        self.addChild(createGroundNode(view.frame))
    }

    func createGroundNode(_ frame:NSRect) -> SKNode
    {
        let rect = CGRect(x:0,y:0,width:frame.width,height:200)
        let ground = SKShapeNode(rect:rect);
        ground.fillColor = NSColor(red:0,green:8,blue:0,alpha:1);
        return ground;
    }
}
