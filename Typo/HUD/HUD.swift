//
//  GameScene.swift
//  Typo
//
//  Created by Carl-Johan Svedin on 2014-06-06.
//  Copyright (c) 2014 Carl-Johan Svedin. All rights reserved.
//

import SpriteKit

class HUD: SKNode, CJProgressListenerProtocol {

    let progressBar = ProgressBar()
    
    init (size:CGSize) {
        super.init()
        /* Setup your scene here */
        
        progressBar.position = CGPoint(x:size.width-200,y:size.height-400)
        progressBar.progress = 0.5
        self.addChild(progressBar)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func progressChanged(newValue v:CGFloat){
        progressBar.progress=v
    }
    
}
