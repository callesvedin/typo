import Cocoa
import SpriteKit
import XCPlayground

class MyScene: SKScene {
    var _previousTime = 0.0
    var _currentTime = 0.0
    var _deltaTime = 0.0
    
    override func didMoveToView(view: SKView!) {
    }
    
    override func update(currentTime: NSTimeInterval) {
        if _previousTime == 0.0 { _previousTime = currentTime }
        _deltaTime = currentTime - _previousTime
        _previousTime = currentTime
    }
}

class RandomNumberGenerator {
    
    func randomInt(from:Int, to:Int) -> Int {
        return from+random(to-from+1)
    }
    
    func random(count:Int) -> Int {
        return Int(arc4random_uniform(UInt32(count)))
    }
}

class GroundNode:SKNode{
    
    var imageNodes:SKSpriteNode[]
    let frameSize:CGSize
    let groundImage = SKSpriteNode(imageNamed: "SA-GroundG01.png")
    let w:CGFloat
    let h:CGFloat
    
    init(frameSize:CGSize) {
        imageNodes=SKSpriteNode[]()
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
            sprite.position = CGPoint(x:nextXPosition,y:h)
            addChild(sprite)
            nextXPosition+=w
        }
    }
}
var view = SKView(frame:NSRect(x: 0.0, y: 0.0, width: 1024, height: 768))
XCPShowView("View", view)

var scene = MyScene(size: CGSize(width: 1024.0, height: 768.0))
view.presentScene(scene)
scene.backgroundColor = NSColor.blackColor()

scene.addChild(GroundNode(frameSize: view.frame.size))

