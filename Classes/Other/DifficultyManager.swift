//
//  DifficultyManager.swift
//  CapGame
//
//  Created by Brandy Austin on 7/20/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import Foundation

//class DifficultyManager: NSObject, NSCoding {

class DifficultyManager {
    
    static let instance = DifficultyManager();
    
    private init() {}
    
    private(set) var insectFactor = Int();
    private(set) var drinkFactor = Int();
    private(set) var planeFactor = Int();
    
    private(set) var portalFactor = Int();
    private(set) var bonusFactor = Int();
    
    private(set) var startAloneFactor = Int();
    private(set) var lowMiddleEndFactor = Int();
    private(set) var highMiddleEndFactor = Int();
    private(set) var lowHighFactor = Int();

    
    func setFactors(difficulty: String) {
        switch difficulty {
            case "easy":
                insectFactor = 2;
                drinkFactor = 4;
                planeFactor = 3;
        
                portalFactor = 4;
                bonusFactor = 4;
        
                startAloneFactor = 8;
                lowMiddleEndFactor = 8;
                highMiddleEndFactor = 8;
                lowHighFactor = 5;
                return
        
            case "medium":
                insectFactor = 4;
                drinkFactor = 3;
                planeFactor = 3;
        
                portalFactor = 4;
                bonusFactor = 2;
        
                startAloneFactor = 6;
                lowMiddleEndFactor = 6;
                highMiddleEndFactor = 6;
                lowHighFactor = 6;
                return
        
            case "hard":
                insectFactor = 6;
                drinkFactor = 2;
                planeFactor = 3;
        
                portalFactor = 4;
                bonusFactor = 1;
        
                startAloneFactor = 5;
                lowMiddleEndFactor = 5;
                highMiddleEndFactor = 5;
                lowHighFactor = 6;
                return
        
            default:
                return
        }
    }
}
