//
//  CJProgressBar.swift
//  Typo
//
//  Created by carl-johan.svedin on 2014-11-02.
//  Copyright (c) 2014 Carl-Johan Svedin. All rights reserved.
//

import SpriteKit

class ProgressBar:SKCropNode
{

    var progress:CGFloat {
        get{
            return self.maskNode!.yScale
        }
        set{
            self.maskNode!.yScale=newValue
        }
    }
    
    

    override init()
    {
        super.init()        
        let child = SKSpriteNode(imageNamed:"Progress")
        child.anchorPoint = CGPoint(x:0.5,y:0)
        self.maskNode = SKSpriteNode(color:NSColor.whiteColor(),size:CGSize(width:child.size.width,height:child.size.height))
        self.addChild(child);
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}