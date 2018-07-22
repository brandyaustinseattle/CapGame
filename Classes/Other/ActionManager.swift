//
//  ActionManager.swift
//  CapGame
//
//  Created by Brandy Austin on 7/21/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class ActionManager {
    
    static let instance = ActionManager();

    private init() {}

    func removeAfter(seconds: Double, node: SKSpriteNode) {
        let wait = SKAction.wait(forDuration: seconds)
        let hide = SKAction.hide();
        let sequence = SKAction.sequence([wait, hide]);
        
        node.run(SKAction.repeatForever(sequence), withKey: "remove");
    }
    
    func delayFor(seconds: Double, node: SKSpriteNode) {
        let wait = SKAction.wait(forDuration: seconds)
        
        node.run(wait, withKey: "wait");
    }
    
    func flashForever(node: SKSpriteNode) {
        let fadeIn = SKAction.fadeIn(withDuration: 0.75);
        let wait = SKAction.wait(forDuration: 0.75)
        let fadeOut = SKAction.fadeOut(withDuration: 0.75);
        let sequence = SKAction.sequence([fadeIn, wait, fadeOut]);
        
        node.run(SKAction.repeatForever(sequence), withKey: "flash");
    }
    
    // similar to rotate drink
    // maybe add SK actions to their own class
    func rotateBubble(node: SKSpriteNode) {
        let rotateBack = SKAction.rotate(toAngle: CGFloat(Double.pi / 100), duration: 1);
        let rotateFront = SKAction.rotate(toAngle: CGFloat(-Double.pi / 100), duration: 1);
        let rotateSequence = SKAction.sequence([rotateBack, rotateFront]);
        
        node.run(SKAction.repeatForever(rotateSequence), withKey: "rotate");
    }
    
}
