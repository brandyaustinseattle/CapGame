//
//  Stand.swift
//  CapGame
//
//  Created by Brandy Austin on 7/12/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class Stand: SKSpriteNode {
    
    var pathItem = PathItem();
    
    func initialize(midPathItemPosition: CGPoint, offsetYValue: CGFloat) {
        
        self.name = "Stand";
        self.zPosition = 2;
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        
        self.setPhysics();
                
        self.position = CGPoint(x: midPathItemPosition.x, y: midPathItemPosition.y + offsetYValue);
        
    }
    
    func setPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height));
        
        self.physicsBody?.usesPreciseCollisionDetection = true;
        self.physicsBody?.categoryBitMask = PhysicsCategory.Stand;
        self.physicsBody?.allowsRotation = false;
        self.physicsBody?.isDynamic = false;
                
        self.setScale(0.5);
    }
}
