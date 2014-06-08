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

    override func didMoveToView(view: SKView) {
        super.didMoveToView(view);
        backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 1)
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
        let node = SKLabelNode(text: String(letter))
        node.position = CGPoint(x:randomGenerator.randomInt(0, to: Int(frame.width)),y:Int(frame.height-40))
        node.fontSize = 30;
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.fontSize/2)
        node.physicsBody.dynamic = true
        node.physicsBody.allowsRotation = false
        node.physicsBody.restitution = 1.0
        node.physicsBody.friction = 0.0
        node.physicsBody.angularDamping = 0.0
        node.physicsBody.linearDamping = 0.0
        return node
    }
}