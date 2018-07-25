//
//  DemoGameScene.swift
//  CapGame
//
//  Created by Brandy Austin on 7/24/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class DemoGameScene: GameScene {

    let instructions = Bubble(type: "instructionscloud", scale: 1, bubblePosition: CGPoint(x: 0, y: 335), label: LabelMaker(message: "", messageSize: 45), zPos: 2);
    
    override func initialize() {
        self.addChild(instructions);
        
        addInstructions();
        
        super.initialize();
    }
    
    func addInstructions() {
        
        let instructions = ["tap to jump", "tap in air to double jump", "collect drinks to rack up points", "...but avoid insects as they steal points", "visit a drink stand to enter a bonus level", "catch a plane to travel to another place"];
        
        var time = Double(4);

        
        for text in instructions {
            delay(time: time) {
                let label = LabelMaker(message: text, messageSize: 45);
                self.instructions.updateLabel(newLabel: label)
            }
            time += 4;
        }
    }
}
