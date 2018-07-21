//
//  Insect.swift
//  CapGame
//
//  Created by Brandy Austin on 7/17/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class Insect: SKSpriteNode {

    func initialize(position: CGPoint) {
        
        self.name = "Insect";
        self.zPosition = 3;
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        
        self.setPhysics();
        
        self.position = CGPoint(x: position.x, y: position.y);
    }
    
    func setPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2, center: CGPoint(x: 0, y: 0));
        
        self.physicsBody?.collisionBitMask = 0;
        self.physicsBody?.usesPreciseCollisionDetection = true;
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.Insect;
        self.physicsBody?.affectedByGravity = false;
        self.physicsBody?.allowsRotation = false;
        self.physicsBody?.isDynamic = false;
        
//        self.setScale(3);
    }
    
    func fly() {
        let fadeIn = SKAction.fadeIn(withDuration: 0.25);
        let fadeOut = SKAction.fadeOut(withDuration: 0.25);
     
        let flyLeft = SKAction.moveBy(x: -150, y: 0, duration: 2);
        let flyRight = SKAction.moveBy(x: 150, y: 0, duration: 2);
        
        let flySequence = SKAction.sequence([fadeIn, flyLeft, fadeOut, fadeIn, flyRight, fadeOut]);
        
        self.run(flySequence);
    }
    
}
