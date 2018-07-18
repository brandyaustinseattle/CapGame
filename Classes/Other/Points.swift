//
//  PointsSingleton.swift
//  CapGame
//
//  Created by Brandy Austin on 7/13/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class Points {

    static let instance = Points();
    // can't create instance of Points outside of class
    private init() {}
    
    var value = Int(0);
    
    func increment(objectName: String) {
        if objectName == "Drink" {
            value += 10; }
        else if objectName == "Lemon" {
            value += 5;
        };
    }
    
    func decrement(pointsLabel: SKLabelNode) {
        if value == 0 {
            return
        }
        
        value -= 1;
    }
    
    func countDown(pointsLabel: SKLabelNode) {
        for _ in 1...value {
            self.decrement(pointsLabel: pointsLabel);
        }
    }
    
    func getBackground() -> SKSpriteNode {
        
        let pointCloud = SKSpriteNode(imageNamed: "roundcloud");
                
        pointCloud.name = "Round";
        pointCloud.zPosition = 3;
        pointCloud.setScale(0.75);
        pointCloud.position = CGPoint(x: 590, y: 320);
        
        return pointCloud;
    }
    
    func getLabel() -> SKLabelNode {
        
        let pointsLabel = SKLabelNode(fontNamed: "Marker Felt");
        
        pointsLabel.text = "\(value)";
        pointsLabel.fontColor = UIColor.black;
        pointsLabel.fontSize = 60;
        pointsLabel.zPosition = 4;
        
        pointsLabel.position = CGPoint(x: 585, y: 300);
        
        return pointsLabel;
    };
    
    func updatePointsDisplay(background: SKSpriteNode, pointsLabel: SKLabelNode) {
        
        if value == 0 {
            self.flashBackground(background: background);
        }
            
        pointsLabel.text = "\(value)";
    }
    
    func flashBackground(background: SKSpriteNode) {
        let pinkImage = SKTexture(imageNamed: "pinkroundcloud");
        let makePink = SKAction.setTexture(pinkImage , resize: false);
        
        let whiteImage = SKTexture(imageNamed: "roundcloud");
        let makeWhite = SKAction.setTexture(whiteImage , resize: false);
        
        let wait = SKAction.wait(forDuration: 0.15);
        
        let flash = SKAction.sequence([makePink, wait, makeWhite]);

        background.run(SKAction.repeat(flash, count: 2));

    }
    
}
