//
//  GameplayScene.swift
//  CapGame
//
//  Created by Brandy Austin on 6/26/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
    var player = Player();
    
    override func update(_ currentTime: TimeInterval) {
        moveMountains();
    }
    
    override func didMove(to view: SKView) {
        initialize();
    }
    
    func initialize() {
        createPlayer();
        createMountains();
        createTrees();
        createPath();
    }

    func createMountains() {
        for i in 0...1 {
            let mountains = SKSpriteNode(imageNamed: "mountains");
            mountains.name = "mountains";
            mountains.anchorPoint = CGPoint(x: 0.5, y: 0.5);
            mountains.position = CGPoint(x: CGFloat(i) * mountains.size.width, y:0);
            mountains.zPosition = 0;
            self.addChild(mountains);
        }
    }
    
    func moveMountains() {
        
        enumerateChildNodes(withName: "mountains") {
            node, _ in
            
            let mountainsNode = node as! SKSpriteNode;
            
            mountainsNode.position.x -= 8;
            
            // less than because mountains are scrolling left
            if mountainsNode.position.x < -(mountainsNode.size.width) {
                mountainsNode.position.x += mountainsNode.size.width * 2;
            }
        };
    }
    
    func createTrees() {
        let trees = SKSpriteNode(imageNamed: "trees");
        trees.name = "trees";
        trees.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        trees.position = CGPoint(x: 0, y:0);
        trees.zPosition = 1;
        trees.setScale(0.70);
        self.addChild(trees);
    }
    
    
    func createPath() {
        for i in 0...2 {
            let lowAddOn = SKSpriteNode(imageNamed: "low-add-on");
            lowAddOn.name = "lowAddOn";
            lowAddOn.anchorPoint = CGPoint(x: 0.5, y: 0.5);
            lowAddOn.position = CGPoint(x: CGFloat(i) * (lowAddOn.size.width * 0.55) + -595, y: -305);
            lowAddOn.zPosition = 3;
            lowAddOn.setScale(0.55);
            
            lowAddOn.physicsBody = SKPhysicsBody(rectangleOf: lowAddOn.size);
            lowAddOn.physicsBody?.affectedByGravity = false;
            lowAddOn.physicsBody?.isDynamic = false;
            lowAddOn.physicsBody?.categoryBitMask = PhysicsCategory.ground;
            
            self.addChild(lowAddOn);
        }
    }
    
    func createPlayer() {
        player = Player(imageNamed: "testPlayer");
        player.initialize();
        player.position = CGPoint(x: -580, y: 200);

        self.addChild(player);
    }

}
