//
//  PointsSingleton.swift
//  CapGame
//
//  Created by Brandy Austin on 7/13/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit
import GameplayKit

class PointsSingleton {
    
    static let instance = PointsSingleton();
    // can't create instance of Points outside of class
    private init() {}
    
    var points = Int(0);
    
    func incrementPoints() {
        points += 1;
    }
}
