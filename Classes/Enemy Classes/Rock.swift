//
//  Rock.swift
//  CapGame
//
//  Created by Brandy Austin on 7/17/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class Rock: SKSpriteNode {
        
    func initialize(referencePosition: CGPoint, offsetYValue: CGFloat) {
        
        self.name = "Rock";
        self.zPosition = 3;
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        
        self.setPhysics();
        
        self.position = CGPoint(x: referencePosition.x, y: referencePosition.y + offsetYValue);
    }
    
    func setPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size, center: CGPoint(x: 0, y: 0));
        
        self.physicsBody?.usesPreciseCollisionDetection = true;
        self.physicsBody?.categoryBitMask = PhysicsCategory.Rock;
        self.physicsBody?.affectedByGravity = true;
        self.physicsBody?.allowsRotation = false;
        self.physicsBody?.isDynamic = false;
        
        self.setScale(0.15);
    }
    
}
