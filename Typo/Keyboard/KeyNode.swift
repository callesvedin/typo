//
//  KeyNode.swift
//  Typo
//
//  Created by carl-johan.svedin on 2014-11-24.
//  Copyright (c) 2014 Carl-Johan Svedin. All rights reserved.
//

import SpriteKit


class KeyNode:SKNode{
    
    init(keySize:CGRect, letter:String,selected:Bool) {
        super.init()
        self.position=CGPoint(x:0,y:10)
        let thePath : CGPath = CGPath(roundedRect: keySize, cornerWidth: 8, cornerHeight: 8, transform: nil)
        let shapeNode = SKShapeNode(path:thePath)
        shapeNode.fillColor = NSColor.white
        shapeNode.strokeColor = NSColor.white
        if selected {
            shapeNode.alpha = 0.8
        }else{
            shapeNode.alpha = 0.4
        }
        addChild(shapeNode)
        let labelNode:SKLabelNode = SKLabelNode(text:letter)
        
        labelNode.fontColor = NSColor.black
        labelNode.fontSize = 38
        labelNode.position = CGPoint(x:keySize.width/2,y:(keySize.height/2)-labelNode.frame.height/2)
        addChild(labelNode)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
