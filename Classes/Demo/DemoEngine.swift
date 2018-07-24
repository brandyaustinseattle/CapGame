//
//  Demo.swift
//  CapGame
//
//  Created by Brandy Austin on 7/24/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class DemoEngine: {
    
    
    private let instruction1 = Instruction(message: "tap to jump");
    private let instruction2 = Instruction(message: "tap in air to double jump");
    
    private let instruction3 = Instruction(message: "collect drinks to rack up points");
    private let instruction4 = Instruction(message: "insects sting and steal points");
    private let instructions5 = Instruction(message: "tap and hold to fly to location");
    private let instruction6 = Instruction(message: "visit the stand to enter bonus level");
    private let instruction7 = Instruction(message: "catch the plane to travel to another place");
    
    
    func addJumpInstructions() {
        self.addChild(instruction1);
        ActionManager.instance.removeAfter(node: instruction1, seconds: 2.5);
    
        delay(time: 6) {
            self.addChild(self.instruction2);
            ActionManager.instance.removeAfter(node: self.instruction2, seconds: 2.5);
        }
    }
    
  
    func createRunway(scene: SKScene) {
        
        for _ in 0...5 {
            
            pathItem = PathItem(imageNamed: "\(option)middleLow");
            pathItem.initialize();
            
            pathItem.addPathItem(scene: scene, spaceBefore: Int(0), drinkFlag: false, rockFlag: false);
            
        };
        
        pathItem = PathItem(imageNamed: "\(option)endLow");
        pathItem.initialize();
        
        pathItem.addPathItem(scene: scene, spaceBefore: Int(0), drinkFlag: false, rockFlag: false);
        
        lastType = "end";
        lastHeight = "Low";
    }
    
}
