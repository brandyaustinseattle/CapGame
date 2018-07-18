//
//  Bee.swift
//  CapGame
//
//  Created by Brandy Austin on 7/17/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class Bee: SKSpriteNode {

    func initialize(position: CGPoint) {
        
        self.name = "Bee";
        self.zPosition = 3;
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        
        self.setPhysics();
        
        self.position = CGPoint(x: position.x, y: position.y);
    }
    
    func setPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2, center: CGPoint(x: 0, y: 0));
        
        self.physicsBody?.collisionBitMask = 0;
        self.physicsBody?.usesPreciseCollisionDetection = true;
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.Bee;
        self.physicsBody?.affectedByGravity = false;
        self.physicsBody?.allowsRotation = false;
        self.physicsBody?.isDynamic = false;
        
        self.setScale(0.15);
    }
    
    func fly() {
        let fadeIn = SKAction.fadeIn(withDuration: 0.5);
        let fadeOut = SKAction.fadeOut(withDuration: 0.5);
        
        let leftImage = SKTexture(imageNamed: "leftBee");
        let leftBee = SKAction.setTexture(leftImage, resize: false);
        let flyLeft = SKAction.moveBy(x: -150, y: 0, duration: 2);
        
        let rightImage = SKTexture(imageNamed: "rightBee");
        let rightBee = SKAction.setTexture(rightImage, resize: false);
        let flyRight = SKAction.moveBy(x: 150, y: 0, duration: 2);
        
        let flySequence = SKAction.sequence([leftBee, fadeIn, flyLeft, fadeOut, rightBee, fadeIn, flyRight, fadeOut]);
        
        self.run(flySequence);
    }
    
}
