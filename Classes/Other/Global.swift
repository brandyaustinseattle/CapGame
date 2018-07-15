//
//  Global.swift
//  CapGame
//
//  Created by Brandy Austin on 7/12/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let PlayerBody: UInt32 = 0x1 << 1;
    static let PlayerHead: UInt32 = 0x1 << 2;
    static let Ground: UInt32 = 0x1 << 3;
    static let Drink: UInt32 = 0x1 << 4;
    static let Stand: UInt32 = 0x1 << 5;
}

extension Int {
    static func random(min: Int, max: Int) -> Int {
        precondition(min <= max);
        let randomizer = GKRandomSource.sharedRandom();
        return min + randomizer.nextInt(upperBound: max - min + 1);
    }
}
    
func drinkPulse(position: CGPoint) -> SKEmitterNode {
    let pulse = SKEmitterNode(fileNamed: "Drink");
    pulse?.position = position;
    return pulse!;
}

func lemonPulse(position: CGPoint) -> SKEmitterNode {
    let pulse = SKEmitterNode(fileNamed: "Lemon");
    pulse?.position = position;
    return pulse!;
}
