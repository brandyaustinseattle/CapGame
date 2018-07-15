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
    
    let offSetYArray = [CGFloat(315), CGFloat(450)];
    var drink = Object();
    
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
    
    func addPathItem(gameScene: GameScene, spaceBefore: Int, drinkFlag: Bool) {
        
        if (prevPathItem.name == nil) {
            xValue = -(gameScene.size.width/2) + self.size.width * 0.55/2;
        } else {
            // must subtract 30 to account for fact that width calculations are impacted with lip edges
            let space = CGFloat(spaceBefore);
            xValue = space + prevPathItem.position.x + prevPathItem.size.width/2 + self.size.width * 0.55/2 - 30;
        }

        self.position = CGPoint(x: CGFloat(xValue), y: -(gameScene.frame.size.height/2) + (self.size.height * 0.55/2));
        
        self.setScale(0.55);
        
        self.move(itemToMove: self);
        
        if drinkFlag {
            self.addDrink(referencePosition: self.position, gameScene: gameScene);
        }

        prevPathItem = self;
        
        gameScene.addChild(self);
    }
    
    func addDrink(referencePosition: CGPoint, gameScene: GameScene) {
        drink = Object(imageNamed: "drink");
        
        let index = Int(CGFloat(Int.random(min: 0, max: 1)));
        let offsetYValue = offSetYArray[index];
        
        drink.initialize(referencePosition: referencePosition, offsetYValue: offsetYValue, type: "Drink");
        
        gameScene.addChild(drink);
        
        self.move(itemToMove: drink);
    }
    
    
    
    
    
    
    
    
    func move(itemToMove: SKSpriteNode) {
        let endpoint = CGPoint(x: -800, y: itemToMove.position.y);
        let move = SKAction.move(to: endpoint, duration: getDuration(pointA: itemToMove.position, pointB: endpoint, speed: 175.0))
        
        let remove = SKAction.removeFromParent();
        let sequence = SKAction.sequence([move, remove]);
        itemToMove.run(sequence);
    }
    
    func getDuration(pointA: CGPoint, pointB: CGPoint, speed:CGFloat)->TimeInterval {
        let xDist = (pointB.x - pointA.x)
        let yDist = (pointB.y - pointA.y)
        let distance = sqrt((xDist * xDist) + (yDist * yDist));
        let duration : TimeInterval = TimeInterval(distance/speed)
        return duration
    }

}
