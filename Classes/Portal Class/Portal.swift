//
//  Portal.swift
//  CapGame
//
//  Created by Brandy Austin on 7/12/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class Portal: SKSpriteNode {
    
    var pathItem = PathItem();
    
    func initialize(midPathItemPosition: CGPoint, offsetYValue: CGFloat, type: String) {
                
        self.name = "Portal\(type)";
        self.zPosition = 2;
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        
        self.setPhysics(type: type);
        
        self.position = CGPoint(x: midPathItemPosition.x, y: midPathItemPosition.y + offsetYValue);
        
    }
    
    func setPhysics(type: String) {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width/3, height: self.size.height/3));
        
        self.physicsBody?.collisionBitMask = 0;
        
        self.physicsBody?.usesPreciseCollisionDetection = true;
        self.physicsBody?.categoryBitMask = PhysicsCategory.Portal;
        self.physicsBody?.allowsRotation = false;
        self.physicsBody?.isDynamic = false;
        
        self.setScale(0.5);
    }
    
    // makeBigger is not in use
    func makeBigger() {
        let bigger = SKAction.resize(byWidth: 20, height: 20, duration: 2)
        let wait = SKAction.wait(forDuration: 0.75)
        let regular = SKAction.resize(byWidth: -25, height: -25, duration: 2)
        let sequence = SKAction.sequence([bigger, wait, regular]);
        
        self.run(SKAction.repeatForever(sequence), withKey: "flash");
    }
}

