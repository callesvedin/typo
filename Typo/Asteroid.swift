//
//  Asteroid.swift
//  Typo
//
//  Created by Carl-Johan Svedin on 2014-06-30.
//  Copyright (c) 2014 Carl-Johan Svedin. All rights reserved.
//

import SpriteKit
class Asteroid:GameObject {
    let asteroidAtlas = SKTextureAtlas(named: "asteroid")
    let letter:Character
    let randomGenerator = RandomNumberGenerator()

    init(letter:Character,position:CGPoint) {
        self.letter = letter

//        frames = SKTexture[]()

        
//        frames.append(asteroidAtlas.textureNamed("asteroid_1"))
//        frames.append(asteroidAtlas.textureNamed("asteroid_2"))
//        frames.append(asteroidAtlas.textureNamed("asteroid_3"))
//        frames.append(asteroidAtlas.textureNamed("asteroid_4"))
        super.init()
        self.position = position
        self.name="asteroid"
        setupNode()
    }

    func setupNode()
    {
//        let burstPath = NSBundle.mainBundle().pathForResource("asteroid_fire", ofType: "sks")
//        let burstNode : SKEmitterNode! =  NSKeyedUnarchiver.unarchiveObjectWithFile(burstPath) as SKEmitterNode
  //      burstNode.zPosition = -1
        
        let textureName = "asteroid_\(randomGenerator.randomInt(1, to: 4))"
        let myTexture = asteroidAtlas.textureNamed(textureName)
        let imageNode = SKSpriteNode(texture: myTexture)
        imageNode.setScale(0.3)

  //      let rotation = ((randomGenerator.randomInt(1, to: 2) % 2==0) ? -1:1)*M_PI
  //      let action = SKAction.repeatActionForever(SKAction.rotateByAngle(rotation, duration: NSTimeInterval(1)))
        //        imageNode.runAction(action)
        
        imageNode.anchorPoint = CGPoint(x:0.5,y:0.5)
        
//        let parentNode = SKNode()
//        addChild(burstNode)
        addChild(imageNode)
        physicsBody = SKPhysicsBody(circleOfRadius: imageNode.frame.width/2)
        
        
        physicsBody!.dynamic = true
        physicsBody!.allowsRotation = false
        physicsBody!.restitution = 1.0
        physicsBody!.friction = 0.0
        physicsBody!.angularDamping = 0.0
        physicsBody!.linearDamping = 0.0
        physicsBody!.categoryBitMask = asteroidCategory
        physicsBody!.collisionBitMask = groundCategory
        physicsBody!.contactTestBitMask = groundCategory
        
        if let f = NSFont(name: "Helvetica", size:25) {
            let attributes = [NSFontAttributeName:f, NSForegroundColorAttributeName:NSColor.whiteColor()]
            let ST = String(letter)
            let myString: NSString = ST as NSString
            let size: CGSize = myString.sizeWithAttributes(attributes)
            let image = NSImage(size: size)
            image.lockFocus()
            myString.drawAtPoint(NSZeroPoint, withAttributes: attributes)
            image.unlockFocus()
            let letterNode = SKSpriteNode(texture: SKTexture(image: image))
            //        let letterNode = SKLabelNode(text: String(letter))
            //        letterNode.fontName="Helvetica"
            //        letterNode.fontSize = 25;
            //        letterNode.color = SKColor.whiteColor()
            //        letterNode.colorBlendFactor = 0.5
            letterNode.zPosition = 2
            //        letterNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center //SKLabelVerticalAlignmentModeCenter
            addChild(letterNode)
        }else{
            println("Jesus this sucks!")
        }
        
        
    }
    
    func collidedWith(other: SKPhysicsBody) {
        if let ground = other.node as? GroundNode {
            explode()
        }
    }
    
    func explode(){
        let fade = SKAction.fadeOutWithDuration(0.5)
        let remove = SKAction.runBlock({self.removeAllChildren();self.removeFromParent()})
        let sequence = SKAction.sequence([fade,remove])
        physicsBody!.dynamic=false;
        physicsBody!.velocity=CGVectorMake(0, 0)
        runAction(sequence)
//        removeAllChildren()
//        removeFromParent()
    }
    
}
