//
//  IntroScene.swift
//  CapGame
//
//  Created by Brandy Austin on 7/19/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit
import GameplayKit


class IntroScene: SKScene {

    var player = Player();
    let platform = PathItem(imageNamed: "startStep");

    var introBubble = Bubble();
    
    override func didMove(to view: SKView) {
        initialize();
    }

    func initialize() {
        createStaticMountain();
        createTrees();
    
        addPlatform();
        createPlayer();
    
        addActionBubbles();
        delayIntroBubble();
    }

    func createStaticMountain() {
        let mountains = SKSpriteNode(imageNamed: "mountains");
        mountains.name = "mountains";
        mountains.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        mountains.position = CGPoint(x: 0, y: 0);
        mountains.zPosition = 0;
        self.addChild(mountains);
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

    func addPlatform() {
        platform.initialize();
    
        let x = (self.size.width/2) - (platform.size.width/2);
        let y = -(self.frame.size.height/2) + (platform.size.height/2);
        platform.position = CGPoint(x: x, y: y);
    
        self.addChild(platform);
    }

    func createPlayer() {
        player = Player(imageNamed: "standing1");
        player.initialize();
        player.position = CGPoint(x: 445, y: 200);
        
        self.addChild(player);
        player.stand();
    }

    func delayIntroBubble() {
        let wait = SKAction.wait(forDuration: 1);
        let addIB = SKAction.run(addIntroBubble);
        let sequence = SKAction.sequence([wait, addIB]);
    
        self.run(sequence);
    }

    func addIntroBubble() {
        introBubble = Bubble(imageNamed: "squarespeech");
        introBubble.initialize(type: "Thought")
    
        let position = CGPoint(x: player.position.x + 200, y: player.position.y - 100);
    
        introBubble.addThought(scene: self, text: "let's go", position: position);
        introBubble.flashThought();
    }
    
    
    
    
    func addActionBubbles() {
        let difficulty = ["easy", "medium", "hard"];
        
        var y = self.frame.size.height/2 - self.frame.size.height/6;
        
        for item in difficulty {
            let actionBubble = Bubble(imageNamed: "longcloud");
            actionBubble.initialize(type: "Thought")
            
            let position = CGPoint(x: 0, y: y);
            
            actionBubble.addThought(scene: self, text: "\(item)", position: position);
            
            y -= self.frame.size.height/6;
        }
    }
    
}
