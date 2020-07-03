//
//  SpaceScene.swift
//  Typo
//
//  Created by Carl-Johan Svedin on 2014-06-08.
//  Copyright (c) 2014 Carl-Johan Svedin. All rights reserved.
//

import SpriteKit

class SpaceScene:SKScene,GameOverDelegate, UserWonDelegate, SKPhysicsContactDelegate
{
    var _previousTime = 0.0
    var _deltaTime = 0.0

    var _dropRate:Double = 1
    var _lastDrop = 0.0

    let randomGenerator = RandomNumberGenerator()
    let levelLetters : String = GameData.sharedInstance.getLetters()
    
    let crashDelegate = GameData.sharedInstance
    let hitDelegate = GameData.sharedInstance
    
    var pressedKeys : [Character] = [Character]()
    
    override func didMove(to view: SKView) {
        super.didMove(to: view);
        backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.0);
        self.physicsWorld.contactDelegate = self;
        createBackground()
        let hud = HUD(size: view.frame.size)
        GameData.sharedInstance.progressChangeListener = hud
        GameData.sharedInstance.gameOverDelegate = self
        GameData.sharedInstance.userWonDelegate = self
        GameData.sharedInstance.progress = 0.2
        _dropRate = GameData.sharedInstance.getDropRate()
        hud.zPosition = 3
        self.addChild(hud)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if (!self.isPaused){
            if _previousTime == 0.0 {
                _previousTime = currentTime
                return
            }
            _deltaTime = currentTime - _previousTime
            _previousTime = currentTime
            
            if (currentTime - _lastDrop) > _dropRate {
                self.addChild(createAsteroidNode())
                _lastDrop = currentTime
            }
        }
    }
    
    
    override func keyDown(with event: NSEvent) {
        print("Key code:\(event.keyCode)")
        print("Key characters:\(String(describing: event.characters))")
        let c = Array(event.characters!)[0]
        print("First character:\(c)")
        if let pressedKeys = event.characters {
            let backgroundQueue = OperationQueue()
            backgroundQueue.addOperation(){
                self.handleKeyPresses(pressedKeys)
            }
        }
    }
    
    
    func handleKeyPresses(_ characters:String)
    {
        //self.childNodeWithName("asteroid")
        var minAsteroid:Asteroid?
        let pressedKeys = Array(characters)
        for key in pressedKeys {
            for child in self.children {
                if let asteroid = child as? Asteroid {
                    if key == asteroid.letter {
                        if minAsteroid != nil && minAsteroid!.position.y > asteroid.position.y {
                            minAsteroid=asteroid
                        }else if (minAsteroid == nil) {
                            minAsteroid=asteroid
                        }
                    }
                }
            }
        }
        
        if let hitAsteroid = minAsteroid {
            shotLaser(hitAsteroid)
            hitDelegate.didHit(hitAsteroid.letter)
        }
    }

    func shotLaser(_ astroid:Asteroid){
        var startPos:CGPoint
        var laser:Laser = Laser()
        if astroid.position.x > frame.width/2 {
            laser.position = CGPoint(x:frame.width,y:0);
        }else{
            laser.position = CGPoint(x:0,y:0);
        }
        self.addChild(laser)
        laser.fireAt(astroid);
//        let remove = SKAction.runBlock({self.removeAllChildren();self.removeFromParent()})
    }
    
    func createAsteroidNode() ->SKNode {
        var characterIndex = randomGenerator.randomInt(0, to: levelLetters.characters.count-1)
        let letter = Array(levelLetters)[characterIndex]
        let asteroid = Asteroid(letter: letter)
        asteroid.position = CGPoint(x:randomGenerator.randomInt(Int(asteroid.frame.size.width), to: Int(frame.width-100)),y:Int(frame.height))
        return asteroid
    }
    
    
    func createBackground()
    {
        let background = SKSpriteNode(imageNamed: "stars2")
        background.position = CGPoint(x:self.frame.size.width/2,y:self.frame.size.height/2)
        addChild(background)

        addChild(GroundNode(frameSize:frame.size))
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let asteroid = contact.bodyA.node as? Asteroid {
            asteroid.collidedWith(contact.bodyB)
            crashDelegate.didCrash(asteroid.letter)
        }
    
        if let asteroid = contact.bodyB.node as? Asteroid {
            asteroid.collidedWith(contact.bodyA)
            crashDelegate.didCrash(asteroid.letter)
        }
    }
    
    func userWon() {
        if let scene = SKScene(fileNamed: "WinnerScene") {
//        if let scene = WinnerScene.unarchiveFromFile("WinnerScene") as? WinnerScene {
            let reveal = SKTransition.fade(withDuration: 3)
            scene.scaleMode = SKSceneScaleMode.aspectFill;
            self.view!.presentScene(scene, transition: reveal)
        }
    }
    
    func userDied(){
        if let scene = SKScene(fileNamed: "DeathScene") {
//        if let scene = DeathScene.unarchiveFromFile("DeathScene") as? DeathScene {
            let reveal = SKTransition.fade(withDuration: 3)
            scene.scaleMode = SKSceneScaleMode.aspectFill;
            self.view!.presentScene(scene, transition: reveal)
        }
    }
}
