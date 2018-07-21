//
//  Points.swift
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
    
    var value = Int();
    var amtAdded = String();
    
    func increment(objectName: String) {
        if objectName == "Drink" {
            value += 1;
            amtAdded = "+1";
        } else if objectName == "Bonus" {
            value += 5;
            amtAdded = "+5";
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
        
        let pointsCloud = SKSpriteNode(imageNamed: "roundcloud");
        
        pointsCloud.name = "pointsCloud";
        pointsCloud.zPosition = 3;
        pointsCloud.setScale(0.75);
        pointsCloud.position = CGPoint(x: 590, y: 320);
        
        return pointsCloud;
    }
    
    func getLabel() -> SKLabelNode {
        
        let pointsLabel = SKLabelNode(fontNamed: "Marker Felt");
        
        pointsLabel.name = "pointsLabel";
        pointsLabel.text = "\(value)";
        pointsLabel.fontColor = UIColor.black;
        pointsLabel.fontSize = 60;
        pointsLabel.zPosition = 4;
        
        pointsLabel.position = CGPoint(x: 585, y: 300);
        
        return pointsLabel;
    };
    
    func updatePointsDisplay(background: SKSpriteNode, pointsLabel: SKLabelNode) {

//        if value == 0 {
//            self.flashBackground(background: background);
//            return
//        }
//        
//        let showAdded = SKAction.run {
//            pointsLabel.text = "\(self.amtAdded)";
//        }
//        
//        let showValue = SKAction.run {
//            pointsLabel.text = "\(self.value)";
//        }
//        
//        let wait = SKAction.wait(forDuration: 0.5);
//        
//        let flash = SKAction.sequence([showAdded, wait, showValue]);
//        
//        pointsLabel.run(flash);
        
        if value == 0 {
            self.flashBackground(background: background);
        }
        
        pointsLabel.text = "\(value)";
    }
    
    func flashBackground(background: SKSpriteNode) {
        let grayImage = SKTexture(imageNamed: "grayroundcloud");
        let makeGray = SKAction.setTexture(grayImage, resize: false);
        
        let whiteImage = SKTexture(imageNamed: "roundcloud");
        let makeWhite = SKAction.setTexture(whiteImage , resize: false);
        
        let wait = SKAction.wait(forDuration: 0.15);
        
        let flash = SKAction.sequence([makeGray, wait, makeWhite]);

        background.run(SKAction.repeat(flash, count: 1));

    }
    
}
