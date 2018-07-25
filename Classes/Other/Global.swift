//
//  Global.swift
//  CapGame
//
//  Created by Brandy Austin on 7/12/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit
import GameKit

var demo = false;

struct PhysicsCategory {
    static let PlayerBody: UInt32 = 0x1 << 1;
    static let PlayerHead: UInt32 = 0x1 << 2;
    static let Ground: UInt32 = 0x1 << 3;
    static let Consumable: UInt32 = 0x1 << 4;
    static let Insect: UInt32 = 0x1 << 5;
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

func delay(time: Double, closure: @escaping ()-> ()) {
        
    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
        closure()
    }
}

func transitionScenes(oldScene: SKScene, newScene: SKScene) {
    newScene.scaleMode = .aspectFill;
    
    let doorway = SKTransition.doorway(withDuration: 2.15);
    oldScene.view?.presentScene(newScene, transition: doorway);
}
