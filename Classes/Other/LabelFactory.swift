//
//  LabelFactory.swift
//  CapGame
//
//  Created by Brandy Austin on 7/19/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class LabelFactory: SKLabelNode {
    
    init(message: String, messageSize: CGFloat) {
        
        super.init();
        
        name = text;
        fontName = "Marker Felt";
        text = message;
        fontColor = UIColor.black;
        fontSize = messageSize;
        
        zPosition = 4;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

