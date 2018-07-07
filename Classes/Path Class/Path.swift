//
//  Path.swift
//  CapGame
//
//  Created by Brandy Austin on 7/6/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit
import GameplayKit


extension Int {
    static func random(min: Int, max: Int) -> Int {
        precondition(min <= max);
        let randomizer = GKRandomSource.sharedRandom();
        return min + randomizer.nextInt(upperBound: max - min + 1);
    }
}




class Path {

    var pathImages = [String]();
    var pathOptions = [SKSpriteNode]();

    func initialize() {
        
        pathImages.append(contentsOf: ["left-edge-pink", "low-add-on", "mid-edge-pink", "right-edge-pink", "step-edge", "tall-add-on", "tall-edge", "tall-left", "tall-right"]);
        
        createPathOptions();
    }
    
    func createPathOptions() {
    
        for imageName in pathImages {
            
            let pathItem = SKSpriteNode(imageNamed: imageName);
            
            pathItem.name = "\(imageName)";
            pathItem.zPosition = 2;
            pathItem.anchorPoint = CGPoint(x: 0.5, y: 0.5);
            
            pathItem.physicsBody = SKPhysicsBody(texture: pathItem.texture!, size: pathItem.texture!.size());
            pathItem.physicsBody?.affectedByGravity = false;
            pathItem.physicsBody?.isDynamic = false;
            pathItem.physicsBody?.categoryBitMask = PhysicsCategory.Ground;
            
            pathOptions.append(pathItem);
        }
    }
}

