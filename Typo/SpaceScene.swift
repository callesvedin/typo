//
//  SpaceScene.swift
//  Typo
//
//  Created by Carl-Johan Svedin on 2014-06-08.
//  Copyright (c) 2014 Carl-Johan Svedin. All rights reserved.
//

import SpriteKit

class SpaceScene:GameScene
{
    let _dropRate = 1
    var _lastDrop = 0.0
    var _letters: Character[] = ["a","s","d","f","j","k","l","ö"]
    let randomGenerator = RandomNumberGenerator()

    let asteroidAtlas = SKTextureAtlas(named: "asteroid")
    var frames = SKTexture[]()
//    let burstData:NSData
//    let path:String
    var burstPath:String = ""
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view);
        
//        let burstPath = NSBundle(identifier: "asteroid_smoke");
        burstPath = NSBundle.mainBundle().pathForResource("asteroid_fire", ofType: "sks")
        
        //        burstData = NSData.dataWithContentsOfFile(path, options: .DataReadingUncached, error: nil)
        
        //            [[NSBundle mainBundle]
        //                pathForResource:@"asteroid_smoke" ofType:@"sks"];
        
        backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 1)
        frames.append(asteroidAtlas.textureNamed("asteroid_1"))
        frames.append(asteroidAtlas.textureNamed("asteroid_2"))
        frames.append(asteroidAtlas.textureNamed("asteroid_3"))
        frames.append(asteroidAtlas.textureNamed("asteroid_4"))

    }
    
    override func update(currentTime: CFTimeInterval) {
        if !_gamePaused {            
            if _previousTime == 0.0 {
                _previousTime = currentTime
            }
            _deltaTime = currentTime - _previousTime
            _previousTime = currentTime
            
            if currentTime - _lastDrop > 1 {
                var characterIndex = randomGenerator.randomInt(0, to: _letters.count-1)
                self.addChild(createCharacterNode(_letters[characterIndex]))
                _lastDrop = currentTime
            }
        }
    }
    
    func createCharacterNode(letter: Character) ->SKNode {

        var burstNode : SKEmitterNode! =  NSKeyedUnarchiver.unarchiveObjectWithFile(burstPath) as SKEmitterNode
        burstNode.zPosition = -1
        //var burstNode:SKEmitterNode = archiver.decodeObject() as SKEmitterNode;
        
//        var burstNode:SKEmitterNode = NSKeyedUnarchiver()
        
//            [NSKeyedUnarchiver unarchiveObjectWithFile:burstPath];       let archiver = NSKeyedUnarchiver(forReadingWithData: burstData)
        
        
        let imageNode = SKSpriteNode(texture: frames[randomGenerator.randomInt(0, to: 3)])
        imageNode.setScale(0.3)

        let rotation = ((randomGenerator.randomInt(1, to: 2) % 2==0) ? -1:1)*M_PI
        let action = SKAction.repeatActionForever(SKAction.rotateByAngle(rotation, duration: NSTimeInterval(1)))
//        imageNode.runAction(action)
        
        println("imageNode size:\(imageNode.frame.width)")
        imageNode.anchorPoint = CGPoint(x:0.5,y:0.5)

        let parentNode = SKNode()
        parentNode.addChild(burstNode)
        parentNode.addChild(imageNode)
        parentNode.position = CGPoint(x:randomGenerator.randomInt(0, to: Int(frame.width)),y:Int(frame.height))
        parentNode.physicsBody = SKPhysicsBody(circleOfRadius: imageNode.frame.width/2)

        parentNode.physicsBody.dynamic = true
        parentNode.physicsBody.allowsRotation = false
        parentNode.physicsBody.restitution = 1.0
        parentNode.physicsBody.friction = 0.0
        parentNode.physicsBody.angularDamping = 0.0
        parentNode.physicsBody.linearDamping = 0.0
        let letterNode = SKLabelNode(text: String(letter))
        letterNode.fontName="Helvetica"
        letterNode.fontSize = 25;
        letterNode.color = SKColor.whiteColor()
//        letterNode.colorBlendFactor = 0.5
        letterNode.zPosition = 2
        parentNode.addChild(letterNode)
        letterNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center //SKLabelVerticalAlignmentModeCenter

        return parentNode
    }
}