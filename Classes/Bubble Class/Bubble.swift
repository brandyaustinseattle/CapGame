//
//  Bubble.swift
//  CapGame
//
//  Created by Brandy Austin on 7/19/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

// for bonus scene 75
// for game scene 05

class Bubble: SKSpriteNode {
    
    init(type: String,
         scale: CGFloat,
         bubblePosition: CGPoint,
         label: SKLabelNode?,
         zPos: CGFloat = 4) {
        
        let image = SKTexture(imageNamed: type);
        
        super.init(texture: image, color: UIColor.white, size: image.size())
        
        name = type;
        anchorPoint = CGPoint(x: 0.5, y: 0.5);
        zPosition = zPos;
        setScale(scale);
        
        position = bubblePosition;
        
        if label != nil {
            addChild(label!);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

