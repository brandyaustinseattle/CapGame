//
//  Global.swift
//  CapGame
//
//  Created by Brandy Austin on 7/12/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit
import GameKit

var option = String();

func setSceneOption() -> String {
    let sceneOptions = ["A", "B", "C"];
    let sceneIndex = Int(CGFloat(Int.random(min: 0, max: 1)));
    option = sceneOptions[sceneIndex];
    
    return option;
}

struct PhysicsCategory {
    static let PlayerBody: UInt32 = 0x1 << 1;
    static let PlayerHead: UInt32 = 0x1 << 2;
    static let Ground: UInt32 = 0x1 << 3;
    static let Object: UInt32 = 0x1 << 4;
    static let Bee: UInt32 = 0x1 << 5;
    static let Rock: UInt32 = 0x1 << 6;
    static let Portal: UInt32 = 0x1 << 7;
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


func buttonPulse(position: CGPoint) -> SKEmitterNode {
    let pulse = SKEmitterNode(fileNamed: "Button");
    pulse?.position = position;
    return pulse!;
}

