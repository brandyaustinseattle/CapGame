//
//  InstructionsManager.swift
//  CapGame
//
//  Created by Brandy Austin on 7/24/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//


import SpriteKit

class Instruction: Bubble {
    
    
    
    init(message: String) {
        
        let label = LabelMaker(message: message, messageSize: 45)
        
        super.init(type: "instructionscloud",
                   scale: 1,
//                   bubblePosition: CGPoint(x: 0, y: frame.size.height/2 - 75),

                   bubblePosition: CGPoint(x: 0, y: 250),
                   label: label,
                   zPos: 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
