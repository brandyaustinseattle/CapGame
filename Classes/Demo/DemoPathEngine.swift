//
//  Demo.swift
//  CapGame
//
//  Created by Brandy Austin on 7/24/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

//import SpriteKit
//
//class DemoPathEngine: PathEngine {
//    
//    private let instruction1 = Instruction(message: "tap to jump");
//    private let instruction2 = Instruction(message: "tap in air to double jump");
//    
//    private let instruction3 = Instruction(message: "collect drinks to rack up points");
//    
//    private let instruction4 = Instruction(message: "insects sting and steal points");
//    private let instructions5 = Instruction(message: "tap and hold to fly to location");
//    private let instruction6 = Instruction(message: "visit the stand to enter bonus level");
//    private let instruction7 = Instruction(message: "catch the plane to travel to another place");
//    
//    
//    override func initialize(scene: SKScene) {
//        addInstructions(scene: scene);
//        createRunwayBlock(scene: scene);
//        createFirstBlock(scene: scene);
//        createSecondBlock(scene: scene);
//    }
//    
//    func addInstructions(scene: SKScene) {
//        scene.addChild(instruction1);
//        ActionManager.instance.removeAfter(node: instruction1, seconds: 3);
//
//        delay(time: 6) {
//            scene.addChild(self.instruction2);
//            ActionManager.instance.removeAfter(node: self.instruction2, seconds: 3);
//        }
//        
//        delay(time: 10) {
//            scene.addChild(self.instruction3);
//            ActionManager.instance.removeAfter(node: self.instruction2, seconds: 3);
//        }
//    }
//
//    func createRunwayBlock(scene: SKScene) {
//
//        for _ in 0...5 {
//
//            pathItem = PathItem(imageNamed: "\(option)middleLow");
//            pathItem.initialize();
//
//            pathItem.addPathItem(scene: scene, spaceBefore: Int(0), drinkFlag: false, rockFlag: false);
//
//        };
//
//        pathItem = PathItem(imageNamed: "\(option)endLow");
//        pathItem.initialize();
//
//        pathItem.addPathItem(scene: scene, spaceBefore: Int(0), drinkFlag: false, rockFlag: false);
//
//    }
//    
//    func createFirstBlock(scene: SKScene) {
//        
//        pathItem = PathItem(imageNamed: "\(option)startLow");
//        pathItem.initialize();
//        
//        pathItem.addPathItem(scene: scene, spaceBefore: Int(85), drinkFlag: false, rockFlag: false);
//        
//        for _ in 0...5 {
//            
//            pathItem = PathItem(imageNamed: "\(option)middleLow");
//            pathItem.initialize();
//            
//            pathItem.addPathItem(scene: scene, spaceBefore: Int(0), drinkFlag: false, rockFlag: false);
//            
//        };
//        
//        pathItem = PathItem(imageNamed: "\(option)endLow");
//        pathItem.initialize();
//        
//        pathItem.addPathItem(scene: scene, spaceBefore: Int(0), drinkFlag: false, rockFlag: false);
//    }
//    
//    
//    func createSecondBlock(scene: SKScene) {
//        
//        pathItem = PathItem(imageNamed: "\(option)startLow");
//        pathItem.initialize();
//        
//        pathItem.addPathItem(scene: scene, spaceBefore: Int(85), drinkFlag: false, rockFlag: false);
//        
//        for _ in 0...1 {
//            
//            pathItem = PathItem(imageNamed: "\(option)middleLow");
//            pathItem.initialize();
//            
//            pathItem.addPathItem(scene: scene, spaceBefore: Int(0), drinkFlag: false, rockFlag: false);
//            
//        };
//        
//        for _ in 0...2 {
//            
//            pathItem = PathItem(imageNamed: "\(option)middleLow");
//            pathItem.initialize();
//            
//            pathItem.addPathItem(scene: scene, spaceBefore: Int(0), drinkFlag: true, rockFlag: false);
//            
//        };
//        
//        pathItem = PathItem(imageNamed: "\(option)endLow");
//        pathItem.initialize();
//        
//        pathItem.addPathItem(scene: scene, spaceBefore: Int(0), drinkFlag: false, rockFlag: false);
//    }
//    
//}
