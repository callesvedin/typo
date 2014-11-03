//
//  SpaceScene.swift
//  Typo
//
//  Created by Carl-Johan Svedin on 2014-06-08.
//  Copyright (c) 2014 Carl-Johan Svedin. All rights reserved.
//

import SpriteKit

class SpaceScene:SKScene, SKPhysicsContactDelegate
{
    var _previousTime = 0.0
    var _deltaTime = 0.0

    let _dropRate = 1
    var _lastDrop = 0.0

    let randomGenerator = RandomNumberGenerator()
    let levelLetters : String = GameData.sharedInstance.getLetters()
    
    let crashDelegate = GameData.sharedInstance
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view);
        
        backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.physicsWorld.gravity = CGVectorMake(0.0, -1.0);
        self.physicsWorld.contactDelegate = self;
        createBackground()
        let hud = HUD(size: view.frame.size)
        GameData.sharedInstance.progressChangeListener = hud
        hud.zPosition = 3
        self.addChild(hud)
//        view.paused=false
    }
    
    override func update(currentTime: CFTimeInterval) {
        if (!self.paused){
            if _previousTime == 0.0 {
                _previousTime = currentTime
                return
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
            crashDelegate.didCrash(asteroid.letter)
        }
    
        if let asteroid = contact.bodyB.node as? Asteroid {
            asteroid.collidedWith(contact.bodyA)
            crashDelegate.didCrash(asteroid.letter)
        }
    }
    
}