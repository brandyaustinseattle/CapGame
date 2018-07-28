//
//  DemoGameScene.swift
//  CapGame
//
//  Created by Brandy Austin on 7/24/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class DemoGameScene: GameScene {

    private var timer = Timer();
    
    let instructions = Bubble(type: "instructionscloud", scale: 1.25, bubblePosition: CGPoint(x: 0, y: 335), label: LabelMaker(message: "", messageSize: 45), zPos: 2);
    
    override func initialize() {
        
        self.addChild(instructions);
        
        // add instructions once at initialization
        addInstructions();
        
        // continue repeating instructions on a timer
        timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(addInstructions), userInfo: scene, repeats: true);
        
        super.initialize();
        
        addInstructionsBubble();
    }
    
    override func playerDied() {
        timer.invalidate();
        pathEngine.timer.invalidate();
        
        let demoGameOverScene = DemoGameOverScene(fileNamed: "DemoGameOverScene")!;
        transitionScenes(oldScene: self, newScene: demoGameOverScene)
    }
    
    @objc func addInstructions() {
        
        let instructions = ["tap to jump", "tap in air to double jump", "collect drinks to rack up points", "...but avoid insects as they steal points", "visit a drink stand to enter a bonus level", "stop by pat's bakery for a treat", "catch a plane to travel to another place"];
        
        var time = Double(0);
        
        for text in instructions {
            delay(time: time) {
                let label = LabelMaker(message: text, messageSize: 45);
                self.instructions.updateLabel(newLabel: label)
            }
            time += 4;
        }
    }
    
    func addInstructionsBubble() {
        if playerSpeaking {return};
        
        playerSpeaking = true;
        
        let position = CGPoint(x: player.position.x + 185, y: player.position.y + 50);
        let label = LabelMaker(message: "see above", messageSize: 95);
        label.position = CGPoint(x: 0, y: 20);
        
        let plus = Bubble(type: "boltspeech", scale: 0.45, bubblePosition: position, label: label)
        
        self.addChild(plus);
        ActionManager.instance.removeAfter(node: plus, seconds: 1.5);
        
        delay(time: 2) {
            self.playerSpeaking = false;
        }
    }
    
}
