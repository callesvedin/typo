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

    init(letter:Character) {
        self.letter = letter
        super.init()
        self.name="asteroid"
        GameData.sharedInstance.getLetters()
        setupNode()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   
    func setupNode()
    {
        let burstPath = Bundle.main.path(forResource: "asteroid_fire", ofType: "sks")
        let burstNode : SKEmitterNode! =  NSKeyedUnarchiver.unarchiveObject(withFile: burstPath!) as! SKEmitterNode
        burstNode.zPosition = 1
        
        let textureName = "asteroid_\(randomGenerator.randomInt(1, to: 4))"
        let asteroidTexure = asteroidAtlas.textureNamed(textureName)
        let imageNode = SKSpriteNode(texture: asteroidTexure)
//        imageNode.blendMode = SKBlendMode.Replace
//        imageNode.setScale(0.5)

//        let rotation = ((randomGenerator.randomInt(1, to: 2) % 2==0) ? -1:1)*M_PI
//        let action = SKAction.repeatActionForever(SKAction.rotateByAngle(rotation, duration: NSTimeInterval(1)))
        
        imageNode.anchorPoint = CGPoint(x:0.5,y:0.5)
        imageNode.zPosition = 2
        physicsBody = SKPhysicsBody(circleOfRadius: imageNode.frame.width/2)
//
        physicsBody!.isDynamic = true
        physicsBody!.affectedByGravity = true
        physicsBody!.allowsRotation = false
        physicsBody!.restitution = 0.0
        physicsBody!.friction = 0.0
        physicsBody!.angularDamping = 0.0
        physicsBody!.linearDamping = 0.0
        physicsBody!.categoryBitMask = asteroidCategory
        physicsBody!.collisionBitMask = groundCategory
        physicsBody!.contactTestBitMask = groundCategory
        let randomSpeed = GameData.sharedInstance.getRandomSpeed()
        physicsBody!.velocity = CGVector(dx: 0,dy: randomSpeed)
        if let letterImage = CharacterImageFactory.shared.getImageForLetter(letter) {
            let letterNode = SKSpriteNode(texture: letterImage)
            letterNode.zPosition = 3
            letterNode.anchorPoint=CGPoint(x:0.5,y:0.5)
            imageNode.addChild(letterNode)
        }else{
            print("Could not create image for letter '\(letter)'")
        }
        addChild(imageNode)
        addChild(burstNode)
    }
    
    func collidedWith(_ other: SKPhysicsBody) {
        print("Astroid Collided with \(other.node)")
        if let ground = other.node as? GroundNode {
            explode()
        }else if let ground = other.node as? Laser {
            hit()
        }

    }
    
    func hit(){
        let burstPath = Bundle.main.path(forResource: "explosion", ofType: "sks")
        let explosionNode : SKEmitterNode! =  NSKeyedUnarchiver.unarchiveObject(withFile: burstPath!) as! SKEmitterNode
        explosionNode.zPosition = 3
        self.addChild(explosionNode);
        
        let fade = SKAction.fadeOut(withDuration: 0.3)
        let remove = SKAction.run({self.removeAllChildren();self.removeFromParent()})
        
        let sequence = SKAction.sequence([fade,remove])
        physicsBody!.isDynamic=false;
        physicsBody!.velocity=CGVector(dx: 0, dy: 0)
        run(sequence)
    }
    
    func explode(){
        let fade = SKAction.fadeOut(withDuration: 0.5)
        let remove = SKAction.run({self.removeAllChildren();self.removeFromParent()})
        let sequence = SKAction.sequence([fade,remove])
        physicsBody!.isDynamic=false;
        physicsBody!.velocity=CGVector(dx: 0, dy: 0)
        run(sequence)
    }
    
}
