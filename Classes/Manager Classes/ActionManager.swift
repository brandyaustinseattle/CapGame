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
    
    func removeAfter(node: SKSpriteNode, seconds: Double) {
        let wait = SKAction.wait(forDuration: seconds)
        let hide = SKAction.hide();
        let sequence = SKAction.sequence([wait, hide]);
        
        node.run(sequence, withKey: "remove");
    }
    
    func flashForever(node: SKSpriteNode) {
        let fadeIn = SKAction.fadeIn(withDuration: 0.75);
        let wait = SKAction.wait(forDuration: 0.75)
        let fadeOut = SKAction.fadeOut(withDuration: 0.75);
        let sequence = SKAction.sequence([fadeIn, wait, fadeOut]);
        
        node.run(SKAction.repeatForever(sequence), withKey: "flashForever");
    }
    
    func flashAltTexture(node: SKSpriteNode, textureOne: SKTexture, textureTwo: SKTexture) {
        let addTextureOne = SKAction.setTexture(textureOne, resize: false);
        let addTextureTwo = SKAction.setTexture(textureTwo , resize: false);
        
        let wait = SKAction.wait(forDuration: 0.25);
        
        let flash = SKAction.sequence([addTextureTwo, wait, addTextureOne]);
        
        node.run(flash);
    }
    
    func rotateBackForth(node: SKSpriteNode, denominator: Double) {
        let rotateBack = SKAction.rotate(toAngle: CGFloat(Double.pi / denominator), duration: 1);
        let rotateFront = SKAction.rotate(toAngle: CGFloat(-Double.pi / denominator), duration: 1);
        let rotateSequence = SKAction.sequence([rotateBack, rotateFront]);
        
        node.run(SKAction.repeatForever(rotateSequence), withKey: "rotate");
    }
    
    func move(node: SKSpriteNode) {
        let selectedSpeed = DifficultyManager.instance.speed;
        let endpoint = CGPoint(x: -800, y: node.position.y);
        let duration = getDuration(pointA: node.position, pointB: endpoint, speed: selectedSpeed);
        
        let move = SKAction.move(to: endpoint, duration: duration);
        
        let remove = SKAction.removeFromParent();
        let sequence = SKAction.sequence([move, remove]);
        node.run(sequence);
    }
    
    func getDuration(pointA: CGPoint, pointB: CGPoint, speed: CGFloat)->TimeInterval {
        let xDist = (pointB.x - pointA.x)
        let yDist = (pointB.y - pointA.y)
        let distance = sqrt((xDist * xDist) + (yDist * yDist));
        let duration : TimeInterval = TimeInterval(distance/speed)
        return duration
    }
    
    func contactPulse(position: CGPoint) -> SKEmitterNode {
        let pulse = SKEmitterNode(fileNamed: "\(option)Burst");
        pulse?.position = position;
        return pulse!;
    }
    
}
