//
//  LabelMaker.swift
//  CapGame
//
//  Created by Brandy Austin on 7/19/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class LabelMaker: SKLabelNode {
    
    init(message: String, messageSize: CGFloat) {
        
        super.init();
        
        name = "Label";
        fontName = "Marker Felt";
        text = message;
        fontColor = UIColor.black;
        fontSize = messageSize;
        
        zPosition = 5;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


