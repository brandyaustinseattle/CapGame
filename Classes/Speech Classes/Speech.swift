//
//  Speech.swift
//  CapGame
//
//  Created by Brandy Austin on 7/16/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class Speech: SKSpriteNode {
    
    func initialize(type: String) {

            self.name = type;
            self.anchorPoint = CGPoint(x: 0.5, y: 0.5);
            self.zPosition = 2;
            
            self.setScale(0.5);
    }
    
    func addThought(scene: SKScene, text: String, position: CGPoint) {
       
        let x = position.x - 200;
        let y = position.y + 300;
        
        self.position = CGPoint(x: x, y: y);
        
        self.addLabel(text: text);
        scene.addChild(self);
    }

    func addLabel(text: String) {
        let x = self.position.x;
        let y = self.position.y;
    
        let gameOverLabel = SKLabelNode(fontNamed: "Marker Felt");
        gameOverLabel.text = text;
        gameOverLabel.fontColor = UIColor.black;
        gameOverLabel.fontSize = 85;
        gameOverLabel.zPosition = 4;
    
        gameOverLabel.position = CGPoint(x: x - 325, y: y + 50);
        self.addChild(gameOverLabel);
    }

    func flashThought() {
        let fadeIn = SKAction.fadeIn(withDuration: 1);
        let wait = SKAction.wait(forDuration: 1)
        let fadeOut = SKAction.fadeOut(withDuration: 1);
        let sequence = SKAction.sequence([fadeIn, wait, fadeOut]);
    
        self.run(SKAction.repeatForever(sequence), withKey: "flash");
    }
}
