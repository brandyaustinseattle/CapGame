//
//  Path.swift
//  CapGame
//
//  Created by Brandy Austin on 7/6/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class PathItem: SKSpriteNode {
    
    let offSetYArray = [CGFloat(315), CGFloat(450)];
    var cake = Consumable();
    var rock = Rock();
    
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
        self.setScale(0.55);
    }
    
    func addPathItem(scene: SKScene, spaceBefore: Int, cakeFlag: Bool, rockFlag: Bool) {
        
        if (prevPathItem.name == nil) {
            xValue = -(scene.size.width/2) + self.size.width/2;
        } else {
            // must subtract 45 to account for fact that width calculations are impacted with lip edges
            let space = CGFloat(spaceBefore);
            xValue = space + prevPathItem.position.x + prevPathItem.size.width/2 + self.size.width/2 - 45;
        }

        self.position = CGPoint(x: xValue, y: -(scene.frame.size.height/2) + (self.size.height/2));
        
        ActionManager.instance.move(node: self);

        if cakeFlag {
            self.addCake(referencePosition: self.position, scene: scene);
         
        }
        
        if rockFlag {
            self.addRock(referencePosition: self.position, scene: scene);
        }

        prevPathItem = self;
        scene.addChild(self);
    }
    
    func addCake(referencePosition: CGPoint, scene: SKScene) {

        let cakeNum = Int.random(min: 1, max: 9);
        
        cake = Consumable(imageNamed: "\(cakeNum)cupcake");
        
        let index = Int(CGFloat(Int.random(min: 0, max: 1)));
        let offsetYValue = offSetYArray[index];
        
        cake.initialize(referencePosition: referencePosition, offsetYValue: offsetYValue, type: "Cake");
        
        scene.addChild(cake);
        
        ActionManager.instance.move(node: cake);
    }
    
    func addRock(referencePosition: CGPoint, scene: SKScene) {
        let rockRandom = Int.random(min: 1, max: 3);

        rock = Rock(imageNamed: "rock\(rockRandom)");
        
        let offsetYValue = (rock.size.height * 0.15) / 2 + self.size.height/2 - 10;
        
        rock.initialize(referencePosition: referencePosition, offsetYValue: offsetYValue);
        
        scene.addChild(rock);
        
        ActionManager.instance.move(node: rock);

    }

}
