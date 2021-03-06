//
//  InsectEngine.swift
//  CapGame
//
//  Created by Brandy Austin on 7/17/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit


class InsectEngine {
    
    var timer = Timer();
    
    var insect = Insect();
    
    let xArray = [CGFloat(-350), CGFloat(50), CGFloat(450)];
    let yArray = [CGFloat(260), CGFloat(175)];
    
    func initialize(scene: SKScene) {
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(incrementCounter), userInfo: scene, repeats: true);
    }
        
    @objc func incrementCounter(timer: Timer) {
        
        let insectRandom = Int.random(min: 1, max: 10);
        
        let scene = timer.userInfo as! SKScene;
        
        if insectRandom <= DifficultyManager.instance.insectFactor {
            self.addInsect(scene: scene);
        }
    }
    
    func addInsect(scene: SKScene) {
        
        let insectNum = Int.random(min: 1, max: 8)
        
        let xIndex = Int(CGFloat(Int.random(min: 0, max: 1)));
        let yIndex = Int(CGFloat(Int.random(min: 0, max: 1)));
        
        let randomX = xArray[xIndex];
        let randomY = yArray[yIndex];
        
        let position = CGPoint(x: randomX, y: randomY);
        
        insect = Insect(imageNamed: "\(insectNum)insect");
        insect.initialize(position: position);
        insect.setScale(0.58);
        
        scene.addChild(insect);
        insect.fly();
    }
}
