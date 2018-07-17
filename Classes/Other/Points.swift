//
//  PointsSingleton.swift
//  CapGame
//
//  Created by Brandy Austin on 7/13/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit
import GameplayKit

class Points {
    
    static let instance = Points();
    // can't create instance of Points outside of class
    private init() {}
    
    var value = Int(0);
    
    func increment(objectName: String) {
        if objectName == "Drink" {
            value += 1; }
        else if objectName == "Lemon" {
            value += 5;
        };
    }
    
    func getBackground() -> SKSpriteNode {
        let round = SKSpriteNode(imageNamed: "roundcloud");
        round.name = "Round";
        round.zPosition = 3;
        round.setScale(0.75);
        
        round.position = CGPoint(x: 590, y: 320);
        
        return round;
    }
    
    func updateLabel(pointsLabel: SKLabelNode) {
        
        pointsLabel.text = "\(value)";
        pointsLabel.fontColor = UIColor.black;
        pointsLabel.fontSize = 60;
        pointsLabel.zPosition = 4;
        
        pointsLabel.position = CGPoint(x: 585, y: 300);
        
    }
}
