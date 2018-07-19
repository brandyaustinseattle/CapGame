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
    
    init(scene: SKScene,
         type: String,
         scale: CGFloat,
         position: CGPoint,
         label: SKLabelNode) {
        
        let image = SKTexture(imageNamed: type);
        
        super.init(texture: image, color: UIColor.white, size: image.size())
        
        name = type;
        anchorPoint = CGPoint(x: 0.5, y: 0.5);
        zPosition = 3;
        setScale(scale);
        
        addChild(label);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flashBubble() {
        let fadeIn = SKAction.fadeIn(withDuration: 0.75);
        let wait = SKAction.wait(forDuration: 0.75)
        let fadeOut = SKAction.fadeOut(withDuration: 0.75);
        let sequence = SKAction.sequence([fadeIn, wait, fadeOut]);
        
        self.run(SKAction.repeatForever(sequence), withKey: "flash");
    }
}

