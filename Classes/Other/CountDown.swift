//
//  CountDown.swift
//  CapGame
//
//  Created by Brandy Austin on 7/18/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class CountDown {
    
    let text = "count down"
    var cdValue = Int(10);
    
    func decrement(label: SKLabelNode) {
        if cdValue == 0 {
            return
        }
        cdValue -= 1;
    }
    
    func countDown(label: SKLabelNode) {
        for _ in 1...cdValue {
            self.decrement(label: label);
        }
    }
    
    func getBackground() -> SKSpriteNode {
        
        let bgCloud = SKSpriteNode(imageNamed: "longcloud");
        
        bgCloud.name = "pointsCloud";
        bgCloud.zPosition = 3;
        bgCloud.setScale(0.85);
        bgCloud.position = CGPoint(x: 0, y: 265);
        
        return bgCloud;
    }
    
    func getLabel() -> SKLabelNode {
        
        let cdLabel = SKLabelNode(fontNamed: "Marker Felt");
        
        cdLabel.name = "pointsLabel";
        cdLabel.text = "\(cdValue)";
        cdLabel.fontColor = UIColor.black;
        cdLabel.fontSize = 60;
        cdLabel.zPosition = 4;
        
        cdLabel.position = CGPoint(x: 0, y: 265);
        
        return cdLabel;
    }

    func updateCountDownDisplay(label: SKLabelNode) {
        label.text = "\(cdValue)";
    }
    
    
    
    func flashCDBackground(background: SKSpriteNode) {
        let grayImage = SKTexture(imageNamed: "graylongcloud");
        let makeGray = SKAction.setTexture(grayImage , resize: false);
        
        let whiteImage = SKTexture(imageNamed: "longcloud");
        let makeWhite = SKAction.setTexture(whiteImage , resize: false);
        
        let wait = SKAction.wait(forDuration: 0.5);
        
        let flash = SKAction.sequence([makeGray, wait, makeWhite]);
        
        background.run(flash);
        
    }
    
}

