//
//  Global.swift
//  CapGame
//
//  Created by Brandy Austin on 7/12/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit
import GameKit


struct PhysicsCategory {
    static let PlayerBody: UInt32 = 0x1 << 1;
    static let PlayerHead: UInt32 = 0x1 << 2;
    static let Ground: UInt32 = 0x1 << 3;
    static let Object: UInt32 = 0x1 << 4;
    static let Bee: UInt32 = 0x1 << 5;
    static let Rock: UInt32 = 0x1 << 6;
    static let Portal: UInt32 = 0x1 << 7;
}


struct Easy {
    static let beeFactor: Int = 2;
    static let drinkFactor: Int = 4;
    static let planeFactor: Int = 3;
    
    static let portalFactor: Int = 4;
    static let bonusFactor: Int = 4;
    
    static let startAloneFactor: Int = 8;
    static let lowMiddleEndFactor: Int = 8;
    static let highMiddleEndFactor: Int = 8;
    static let lowHighFactor: Int = 5;
}

struct Medium {
    static let beeFactor: Int = 4;
    static let drinkFactor: Int = 3;
    static let planeFactor: Int = 3;
    
    static let portalFactor: Int = 4;
    static let bonusFactor: Int = 2;
    
    static let startAloneFactor: Int = 6;
    static let lowMiddleEndFactor: Int = 6;
    static let highMiddleEndFactor: Int = 6;
    static let lowHighFactor: Int = 6;
}

struct Hard {
    static let beeFactor: Int = 6;
    static let drinkFactor: Int = 2;
    static let planeFactor: Int = 3;
    
    static let portalFactor: Int = 4;
    static let bonusFactor: Int = 1;
    
    static let startAloneFactor: Int = 5;
    static let lowMiddleEndFactor: Int = 5;
    static let highMiddleEndFactor: Int = 5;
    static let lowHighFactor: Int = 6;
}


extension Int {
    static func random(min: Int, max: Int) -> Int {
        precondition(min <= max);
        let randomizer = GKRandomSource.sharedRandom();
        return min + randomizer.nextInt(upperBound: max - min + 1);
    }
}
    
func contactPulse(position: CGPoint) -> SKEmitterNode {
    let pulse = SKEmitterNode(fileNamed: "Drink");
    pulse?.position = position;
    return pulse!;
}


//func buttonPulse(position: CGPoint) -> SKEmitterNode {
//    let pulse = SKEmitterNode(fileNamed: "Button");
//    pulse?.position = position;
//    return pulse!;
//}

