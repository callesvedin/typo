
import Cocoa
import SpriteKit
import XCPlayground

class MyScene: SKScene {
    var _previousTime = 0.0
    var _currentTime = 0.0
    var _deltaTime = 0.0
    
    override func didMoveToView(view: SKView) {
    }
    
    override func update(currentTime: NSTimeInterval) {
//        if _previousTime == 0.0 { _previousTime = currentTime }
//        _deltaTime = currentTime - _previousTime
//        _previousTime = currentTime
    }
}

class KeyNode:SKNode{
    
    init(keySize:CGRect, letter:String) {
        super.init()
        self.position=CGPoint(x:0,y:10)
        let thePath : CGPath = CGPathCreateWithRoundedRect(keySize, 8, 8, nil)
        let shapeNode = SKShapeNode(path:thePath)
        shapeNode.fillColor = NSColor.whiteColor()
        shapeNode.strokeColor = NSColor.whiteColor()
        shapeNode.alpha = 0.8
        addChild(shapeNode)
        let labelNode:SKLabelNode = SKLabelNode(text:letter)
        
        labelNode.fontColor = NSColor.blackColor()
        labelNode.fontSize = 62
        labelNode.position = CGPoint(x:keySize.width/2,y:(keySize.height/2)-labelNode.frame.height/2)
        addChild(labelNode)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class Keyboard:SKNode{
    override init()
    {
        super.init()
        let keySize : CGRect = CGRect(x: 0,y: 0,width: 100,height: 100)
        let aKey = KeyNode(keySize:keySize,letter:"A")
        aKey.position = CGPoint(x:10,y:400)
        addChild(aKey)
        let sKey = KeyNode(keySize:keySize, letter:"S")
        
        //sKey.position = CGPoint(x:newX,y:400)
        sKey.position = CGPoint(x:aKey.position.x+keySize.width+10,y:400)
        addChild(sKey)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

var view = SKView(frame:NSRect(x: 0.0, y: 0.0, width: 1024, height: 768))
XCPShowView("View", view)

var scene = MyScene(size: CGSize(width: 1024.0, height: 768.0))
view.presentScene(scene)
scene.backgroundColor = NSColor.blackColor()
scene.addChild(Keyboard())