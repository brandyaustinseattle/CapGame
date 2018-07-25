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
        let label = LabelMaker(message: "tap to jump", messageSize: 45);
        instructions.updateLabel(newLabel: label)
        
        delay(time: 4) {
            let label = LabelMaker(message: "tap in air to double jump", messageSize: 45);
            self.instructions.updateLabel(newLabel: label)
        }
        
        delay(time: 8) {
            let label = LabelMaker(message: "collect drinks to rack up points", messageSize: 45);
            self.instructions.updateLabel(newLabel: label)
        }
        
        delay(time: 12) {
            let label = LabelMaker(message: "...but avoid insects as they steal points", messageSize: 45);
            self.instructions.updateLabel(newLabel: label)
        }
        
        delay(time: 16) {
            let label = LabelMaker(message: "visit a drink stand to enter a bonus level", messageSize: 45);
            self.instructions.updateLabel(newLabel: label)
        }
        
        delay(time: 20) {
            let label = LabelMaker(message: "catch a plane to travel to another place", messageSize: 45);
            self.instructions.updateLabel(newLabel: label)
        }
    }
}
