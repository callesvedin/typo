//
//  SpaceScene.swift
//  Typo
//
//  Created by Carl-Johan Svedin on 2014-06-08.
//  Copyright (c) 2014 Carl-Johan Svedin. All rights reserved.
//

import SpriteKit

class SpaceScene:GameScene, SKPhysicsContactDelegate
{    
    let _dropRate = 1
    var _lastDrop = 0.0
    var _letters: [Character] = [] //["a","s","d","f","j","k","l","ö"]
    let randomGenerator = RandomNumberGenerator()
    let levelLetters : String = GameData.sharedInstance.getLetters()
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view);
        backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.physicsWorld.contactDelegate = self;

    }
    
    override func update(currentTime: CFTimeInterval) {
        if !_gamePaused {
            if !_initialized {
                createBackground()
                _initialized = true
            }
            if _previousTime == 0.0 {
                _previousTime = currentTime
            }
            _deltaTime = currentTime - _previousTime
            _previousTime = currentTime
            
            if currentTime - _lastDrop > 1 {
                self.addChild(createAsteroidNode())
                _lastDrop = currentTime
            }
        }
    }
    
    
    
    override func keyDown(event: NSEvent) {
        println("Key code:\(event.keyCode)")
        println("Key characters:\(event.characters)")
        let c = Array(event.characters!)[0]
        println("First character:\(c)")

    }
    
    
    func createAsteroidNode() ->SKNode {
        var characterIndex = randomGenerator.randomInt(0, to: countElements(levelLetters)-1)
        let letter = Array(levelLetters)[characterIndex]
        var position = CGPoint(x:randomGenerator.randomInt(0, to: Int(frame.width)),y:Int(frame.height))
        return Asteroid(letter: letter, position:position)
    }
    
    func createBackground()
    {
        addChild(GroundNode(frameSize:frame.size))
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
    // check the contact.bodyA and contact.bodyB and see if you need to do something
        if let asteroid = contact.bodyA.node as? Asteroid {
            asteroid.collidedWith(contact.bodyB)
        }
    
        if let asteroid = contact.bodyB.node as? Asteroid {
            asteroid.collidedWith(contact.bodyA)
        }
    }
    
}