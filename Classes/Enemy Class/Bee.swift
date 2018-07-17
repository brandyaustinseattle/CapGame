//
//  Bee.swift
//  CapGame
//
//  Created by Brandy Austin on 7/17/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class Bee: SKSpriteNode {

    func initialize(referencePosition: CGPoint, offsetYValue: CGFloat) {
        
        self.name = "Bee";
        self.zPosition = 2;
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        
        self.setPhysics();
        
        self.position = CGPoint(x: referencePosition.x, y: referencePosition.y + offsetYValue);
    }
    
    func setPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2, center: CGPoint(x: 0, y: 0));
        
        self.physicsBody?.collisionBitMask = 0;
        self.physicsBody?.usesPreciseCollisionDetection = true;
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.Bee;
        self.physicsBody?.affectedByGravity = false;
        self.physicsBody?.allowsRotation = false;
        self.physicsBody?.isDynamic = false;
        
        self.setScale(0.25);
    }
    
    func fly() {
        let fadeIn = SKAction.fadeIn(withDuration: 1);
        let fadeOut = SKAction.fadeOut(withDuration: 1);
        
        let leftImage = SKTexture(imageNamed: "leftBee");
        let leftBee = SKAction.setTexture(leftImage, resize: false);
        let flyLeft = SKAction.moveBy(x: -150, y: 0, duration: 2);
        
        let rightImage = SKTexture(imageNamed: "rightBeeBig");
        let rightBee = SKAction.setTexture(rightImage, resize: false);
        let flyRight = SKAction.moveBy(x: 150, y: 0, duration: 2);
        
        let flySequence = SKAction.sequence([leftBee, fadeIn, flyLeft, fadeOut, rightBee, fadeIn, flyRight, fadeOut]);
        
        self.run(SKAction.repeat(flySequence, count: 2), withKey: "flyKey");
    }
}
