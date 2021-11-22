//
//  Keyboard.swift
//  Typo
//
//  Created by carl-johan.svedin on 2014-11-24.
//  Copyright (c) 2014 Carl-Johan Svedin. All rights reserved.
//

import SpriteKit


class Keyboard:SKNode{
    let keyboardCharacters = "qwertyuiopåasdfghjklöäzxcvbnm,.-"
    let keySize : CGRect = CGRect(x: 0,y: 0,width: 50,height: 50)
    
    init(selectedKeys:String)
    {
        super.init()
        let xKeyOffset = (Int(keySize.width) )+10
        let yKeyOffset = (Int(keySize.height) )+10
        
        var xpos:Int = 0
        var ypos = 0
        
        for index in 0...(keyboardCharacters.count-1)
        {

            let character = String(keyboardCharacters[keyboardCharacters.index(keyboardCharacters.startIndex, offsetBy: index)])            
            let aKey = KeyNode(keySize:keySize,letter:character,selected:selectedKeys.range(of:character) != nil)
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
