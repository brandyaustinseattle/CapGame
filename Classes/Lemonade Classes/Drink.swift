//
//  Drink.swift
//  CapGame
//
//  Created by Brandy Austin on 7/10/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class Drink: SKSpriteNode {

    func initialize(pathItemPosition: CGPoint, offsetYValue: Int) {
        
        let offsetY = CGFloat(offsetYValue);
        
        self.name = "Drink";
        self.zPosition = 2;
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        
        self.setPhysics();
        
        self.position = CGPoint(x: pathItemPosition.x, y: pathItemPosition.y + offsetY);
        
        let pulse = SKEmitterNode(fileNamed: "Drink");
        self.addChild(pulse!);
        pulse?.position = CGPoint(x: 0, y: -150);
    }
    
    func setPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/3, center: CGPoint(x: position.x - 25, y: position.y));
        self.physicsBody?.usesPreciseCollisionDetection = true;
        self.physicsBody?.categoryBitMask = PhysicsCategory.Drink;
        self.physicsBody?.affectedByGravity = false;
        self.physicsBody?.isDynamic = false;
        
        self.setScale(0.15);
    }
    
}
