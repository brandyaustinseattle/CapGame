//
//  Consumable.swift
//  CapGame
//
//  Created by Brandy Austin on 7/10/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

// drink and bonus objects that player makes contact with to get points
class Consumable: SKSpriteNode {

    func initialize(referencePosition: CGPoint, offsetYValue: CGFloat, type: String) {
                
        self.name = type;
        self.zPosition = 3;
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        
        if type == "Drink" {
            self.rotateDrink();
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
                
        self.setScale(0.15);
    }
        
    func rotateDrink() {
        let rotateBack = SKAction.rotate(toAngle: CGFloat(Double.pi / 12), duration: 1);
        let rotateFront = SKAction.rotate(toAngle: CGFloat(-Double.pi / 12), duration: 1);
        let rotateSequence = SKAction.sequence([rotateBack, rotateFront]);
            
        self.run(SKAction.repeatForever(rotateSequence), withKey: "rotateKey");
    }
    
    func bonusPulse(position: CGPoint) -> SKEmitterNode {
     
        let pulse = SKEmitterNode(fileNamed: "\(option)Pulse");
        pulse?.position = position;

        return pulse!;
    }
    
}
