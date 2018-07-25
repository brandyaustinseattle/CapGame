//
//  DemoGameOverScene.swift
//  CapGame
//
//  Created by Brandy Austin on 7/25/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class DemoGameOverScene: GameOverScene {
    
    override func addScoreBubbles() { return };
    
    override func addFunctionalityBubbles() {
        
        let position = CGPoint(x: 0, y: 0);
        let button = Bubble(type: "home", scale: 1, bubblePosition: position, label: nil)
            
        self.addChild(button);
        ActionManager.instance.rotateBackForth(node: button, denominator: 100);
    }
    
}
