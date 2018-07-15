//
//  Drink.swift
//  CapGame
//
//  Created by Brandy Austin on 7/10/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class Drink: SKSpriteNode {

    func initialize(referencePosition: CGPoint, offsetYValue: CGFloat) {
                
        self.name = "Drink";
        self.zPosition = 2;
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        
        self.setPhysics();
                
        self.position = CGPoint(x: referencePosition.x, y: referencePosition.y + offsetYValue);
        
        let rotateBack = SKAction.rotate(toAngle: CGFloat(Double.pi / 12), duration: 1);
        let rotateFront = SKAction.rotate(toAngle: CGFloat(-Double.pi / 12), duration: 1);
        let rotateSequence = SKAction.sequence([rotateBack, rotateFront]);
        
        self.run(SKAction.repeatForever(rotateSequence), withKey: "rotateKey");

    }
    
    func setPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/3, center: CGPoint(x: position.x - 25, y: position.y));
        
        // delete following?
        self.physicsBody?.usesPreciseCollisionDetection = true;
        self.physicsBody?.categoryBitMask = PhysicsCategory.Drink;
        self.physicsBody?.affectedByGravity = false;
        self.physicsBody?.allowsRotation = false;
        // delete following?
        self.physicsBody?.isDynamic = false;
                
        self.setScale(0.15);
    }
    
}
