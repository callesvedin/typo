//
//  GroundNode.swift
//  Typo
//
//  Created by Carl-Johan Svedin on 2014-06-30.
//  Copyright (c) 2014 Carl-Johan Svedin. All rights reserved.
//

import SpriteKit

class GroundNode:GameObject{
    
    var imageNodes:[SKSpriteNode]
    let frameSize:CGSize
    let groundImage = SKSpriteNode(imageNamed: "SA-GroundG01.png")
    let w:CGFloat
    let h:CGFloat
    
    init(frameSize:CGSize) {
        imageNodes=[SKSpriteNode]()
        self.frameSize=frameSize
        w = groundImage.size.width
        h = groundImage.size.height
        super.init()
        self.position=CGPoint(x:0,y:10)
        setUpNode()
    }
    

    
    func setUpNode(){
        var nextXPosition:CGFloat=0
        while(nextXPosition<self.frameSize.width){
            let sprite = groundImage.copy() as SKSpriteNode
            sprite.blendMode = SKBlendMode.Replace
            sprite.position = CGPoint(x:nextXPosition,y:h)
            addChild(sprite)
            nextXPosition+=w
        }
        
        physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width:nextXPosition+w,height:h), center:CGPoint(x: (nextXPosition+w)/2, y: h/2))
//        physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)

        if physicsBody != nil {
            physicsBody!.affectedByGravity = false
            physicsBody!.dynamic = false
            physicsBody!.allowsRotation = false
            physicsBody!.categoryBitMask = groundCategory;
            physicsBody!.collisionBitMask = asteroidCategory
            physicsBody!.contactTestBitMask = asteroidCategory
        }
        
    }
}

