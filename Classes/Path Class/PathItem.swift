//
//  Path.swift
//  CapGame
//
//  Created by Brandy Austin on 7/6/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit
import GameplayKit

var prevPathItem = SKSpriteNode();
var xValue = CGFloat(0);

class PathItem: SKSpriteNode {
    
    func initialize() {
        
        self.name = "pathItem";
        self.zPosition = 2;
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        
        self.setPhysics();
    }
    
    func setPhysics() {
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.texture!.size());
        self.physicsBody?.affectedByGravity = false;
        self.physicsBody?.isDynamic = false;
        self.physicsBody?.categoryBitMask = PhysicsCategory.Ground;
    }
    
    func addPathItem(gameScene: GameScene) {
        
        if (prevPathItem.name == nil) {
            xValue = -(gameScene.size.width/2) + self.size.width * 0.55/2;
        } else {
            xValue = prevPathItem.position.x + prevPathItem.size.width/2 + self.size.width * 0.55/2;
        }
        
        print("PLACING PIECE AT");
        print(xValue);

        self.position = CGPoint(x: CGFloat(xValue), y: -(gameScene.frame.size.height/2) + (self.size.height * 0.55/2));
        
        self.setScale(0.55);
        
//        let endpoint = CGPoint(x: self.position.x, y: self.position.y);
//        
//        let move = SKAction.move(to: endpoint, duration: getDuration(pointA: self.position, pointB: endpoint, speed:150.0))
//
//        let remove = SKAction.removeFromParent();
//        let sequence = SKAction.sequence([move, remove]);
//
//        self.run(sequence);
        
        prevPathItem = self;
        
        gameScene.addChild(self);
    }
    
    func getDuration(pointA:CGPoint,pointB:CGPoint,speed:CGFloat)->TimeInterval {
        let xDist = (pointB.x - pointA.x)
        let yDist = (pointB.y - pointA.y)
        let distance = sqrt((xDist * xDist) + (yDist * yDist));
        let duration : TimeInterval = TimeInterval(distance/speed)
        return duration
    }
    
}
