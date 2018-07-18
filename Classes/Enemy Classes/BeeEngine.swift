//
//  BeeEngine.swift
//  CapGame
//
//  Created by Brandy Austin on 7/17/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit


class BeeEngine {
    
    var counter = 1;
    var timer = Timer();
    
    var bee = Bee();
    let beeFactor = 9;
    
    let xArray = [CGFloat(-350), CGFloat(50), CGFloat(450)];
    let yArray = [CGFloat(300), CGFloat(200)];

    func initialize(scene: SKScene) {
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(incrementCounter), userInfo: scene, repeats: true);
    }
    
    @objc func incrementCounter(timer: Timer) {
        counter += 1;
        
        let beeRandom = Int.random(min: 1, max: 10);
        
        let scene = timer.userInfo as! SKScene;
        
        if beeRandom <= beeFactor {
            addBee(scene: scene);
        }
    }
    
    func addBee(scene: SKScene) {
        
        let xIndex = Int(CGFloat(Int.random(min: 0, max: 1)));
        let yIndex = Int(CGFloat(Int.random(min: 0, max: 1)));
        
        let randomX = xArray[xIndex];
        let randomY = yArray[yIndex];
        
        let position = CGPoint(x: randomX, y: randomY);
        
        bee = Bee(imageNamed: "");
        bee.initialize(position: position);
        bee.setScale(0.35);
        
        scene.addChild(bee);
        bee.fly();
    }
    
}
