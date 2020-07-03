
import SpriteKit

class Laser:GameObject {

    let sprite = SKSpriteNode(imageNamed: "laser")
    
    override init() {
        super.init()
        sprite.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        addChild(sprite)
        name="laser"
        zPosition = 3;
        isHidden = true
        setUpPhysics()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
    func setUpPhysics()
    {
//        physicsBody = SKPhysicsBody(edgeLoopFromRect: sprite.frame)
//
//        physicsBody!.dynamic = false
//        physicsBody!.affectedByGravity = false
//        physicsBody!.allowsRotation = true
//        physicsBody!.restitution = 0.0
//        physicsBody!.friction = 0.0
//        physicsBody!.angularDamping = 0.0
//        physicsBody!.linearDamping = 0.0
//        physicsBody!.categoryBitMask = laserCategory
//        physicsBody!.collisionBitMask = asteroidCategory
//        physicsBody!.contactTestBitMask = asteroidCategory
    }

    
    func fireAt(_ target:Asteroid)
    {
        
        var rotation:Float
        let deltaY = Float(position.y - target.position.y)
        let deltaX = Float(position.x - target.position.x)
        let angle = atan2f(deltaY, deltaX)
        //let angle = arctan(deltaY / deltaX)
        rotation = angle
        
        let degToRad = M_PI/180*90
        zRotation = CGFloat(rotation+CFloat(degToRad))
        
        let distance = sqrt(pow((target.position.x - position.x), 2.0) + pow((target.position.y - position.y), 2.0));
        
        //calculate your new duration based on the distance
        let moveDuration = 0.0001*distance;
        let moveAction = SKAction.move(to: target.position, duration: TimeInterval(moveDuration))
        
        let removeSelfAction  = SKAction.removeFromParent()
        let hitAction = SKAction.run({target.hit()})
//        let hitAction = SKAction.runBlock({astroid.hit()})
        let shootAction = SKAction.sequence([moveAction,hitAction,removeSelfAction])
        isHidden = false
        run(shootAction)
    }
}


