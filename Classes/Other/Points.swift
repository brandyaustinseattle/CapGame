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
            value += 5; }
        else if objectName == "Lemon" {
            value += 10;
        };
    }
    
    func updateLabel(pointsLabel: SKLabelNode) {
        
        pointsLabel.text = "\(value) points";
        pointsLabel.fontColor = UIColor.white;
        pointsLabel.fontSize = 60;
        pointsLabel.zPosition = 4;
        
        pointsLabel.position = CGPoint(x: 530, y: 300);
        
    }
}
