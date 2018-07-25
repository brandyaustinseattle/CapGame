//
//  DemoBonusScene.swift
//  CapGame
//
//  Created by Brandy Austin on 7/24/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class DemoBonusScene: BonusScene {
    
    private let instructions = Bubble(type: "instructionscloud", scale: 1, bubblePosition: CGPoint(x: 0, y: 335), label: LabelMaker(message: "tap and hold location to fly there", messageSize: 45), zPos: 2);
    
    override func initialize() {
        self.addChild(instructions);
        
        super.initialize();
    }
    
}
