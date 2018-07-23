//
//  Points.swift
//  CapGame
//
//  Created by Brandy Austin on 7/13/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class Points {

    static let instance = Points();

    private init() {}
    
    var value = Int();
    
    func increment(consumableName: String) {
        if consumableName == "Drink" {
            value += 1;
        } else if consumableName == "Bonus" {
            value += 5;
        }
    }
    
    func decrement() {
        if value == 0 {
            return
        }
        value -= 1;
    }
    
    func getPointsBubble() -> Bubble {
        
        let position = CGPoint(x: 590, y: 320);
        let label = LabelMaker(message: "\(Points.instance.value)", messageSize: 60);
    
        let pointsBubble = Bubble(type: "roundcloud", scale: 0.75, bubblePosition: position, label: label);
        
        return pointsBubble;
    }
    
}
