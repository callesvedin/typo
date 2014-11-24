
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
    
    init(keySize:CGRect, letter:String,selected:Bool) {
        super.init()
        self.position=CGPoint(x:0,y:10)
        let thePath : CGPath = CGPathCreateWithRoundedRect(keySize, 8, 8, nil)
        let shapeNode = SKShapeNode(path:thePath)
        shapeNode.fillColor = NSColor.whiteColor()
        shapeNode.strokeColor = NSColor.whiteColor()
        if selected {
            shapeNode.alpha = 0.8
        }else{
            shapeNode.alpha = 0.4
        }
        addChild(shapeNode)
        let labelNode:SKLabelNode = SKLabelNode(text:letter)
        
        labelNode.fontColor = NSColor.blackColor()
        labelNode.fontSize = 38
        labelNode.position = CGPoint(x:keySize.width/2,y:(keySize.height/2)-labelNode.frame.height/2)
        addChild(labelNode)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class Keyboard:SKNode{
    let keyboardCharacters = "qwertyuiopåasdfghjklöäzxcvbnm,.-"
    let keySize : CGRect = CGRect(x: 0,y: 0,width: 50,height: 50)
    init(selectedKeys:String)
    {
        super.init()
        let xKeyOffset = (Int(keySize.width) )+10
        let yKeyOffset = (Int(keySize.height) )+10

        var xpos:Int = 20
        var ypos = 0
        
        for index in 0...(countElements(keyboardCharacters)-1)
        {
            let characterIndex = advance(keyboardCharacters.startIndex, index)
            let character = String(keyboardCharacters[characterIndex])

            
            let aKey = KeyNode(keySize:keySize,letter:character,selected:selectedKeys.rangeOfString(character) != nil)
            if index == 11 {
                ypos-=yKeyOffset
                xpos=45
            }else if index==22{
                ypos-=yKeyOffset
                xpos=75
            }
            
            aKey.position = CGPoint(x:xpos,y:ypos)
            addChild(aKey)
            xpos += xKeyOffset
        }
        
       // let sKey = KeyNode(keySize:keySize, letter:"S")
        
        //sKey.position = CGPoint(x:newX,y:400)
      //  sKey.position = CGPoint(x:aKey.position.x+keySize.width+10,y:400)
       // addChild(sKey)
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
let keyboard = Keyboard(selectedKeys: "asdfjklö")
keyboard.position = CGPoint(x: 10,y: 400)
scene.addChild(keyboard)
