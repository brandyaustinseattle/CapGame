//
//  Consumable.swift
//  CapGame
//
//  Created by Brandy Austin on 7/10/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

// cake and bonus objects that player makes contact with to get points
class Consumable: SKSpriteNode {

    func initialize(referencePosition: CGPoint, offsetYValue: CGFloat, type: String) {
                
        self.name = type;
        self.zPosition = 3;
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        
        if type == "Cake" {
            self.makeBigger();
        }
        
        if type == "Bonus" {
            let bPulse = self.bonusPulse(position: position);
            self.addChild(bPulse);
        }
        
        self.setPhysics();
        
        self.position = CGPoint(x: referencePosition.x, y: referencePosition.y + offsetYValue);
    }
    
    func setPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/3, center: CGPoint(x: position.x - 25, y: position.y));
        
        self.physicsBody?.collisionBitMask = 0;
        self.physicsBody?.usesPreciseCollisionDetection = true;
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.Consumable;
        self.physicsBody?.affectedByGravity = false;
        self.physicsBody?.allowsRotation = false;
        self.physicsBody?.isDynamic = false;
                
        self.setScale(0.13);
    }
    
    func bonusPulse(position: CGPoint) -> SKEmitterNode {
     
        let pulse = SKEmitterNode(fileNamed: "CPulse");
        pulse?.position = position;

        return pulse!;
    }
    
    func makeBigger() {
        let bigger = SKAction.resize(byWidth: 75, height: 75, duration: 0.5)
        let regular = SKAction.resize(byWidth: -75, height: -75, duration: 0.5)
        let sequence = SKAction.sequence([bigger, regular]);
        
        self.run(SKAction.repeatForever(sequence), withKey: "bigger");
    }
    
}
