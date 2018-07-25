//
//  Data.swift
//  CapGame
//
//  Created by Brandy Austin on 7/24/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import Foundation

class GameData: NSObject, NSCoding {
    
    struct Keys {
        static let EasyDifficultyScore = "EasyDifficultyScore";
        static let MediumDifficultyScore = "MediumDifficultyScore";
        static let HardDifficultyScore = "HardDifficultyScore";
        
        static let EasyDifficulty = "EasyDifficulty";
        static let MediumDifficulty = "MediumDifficulty";
        static let HardDifficulty = "HardDifficulty";
    }
    
    fileprivate var easyDifficultyScore = Int32(0);
    fileprivate var mediumDifficultyScore = Int32(0);
    fileprivate var hardDifficultyScore = Int32(0);
    
    fileprivate var easyDifficulty = false;
    fileprivate var mediumDifficulty = false;
    fileprivate var hardDifficulty = false;
    
    
    override init() {}
    
    required init?(coder aDecoder: NSCoder) {
        self.easyDifficultyScore = aDecoder.decodeInt32(forKey: Keys.EasyDifficultyScore);
        self.mediumDifficultyScore = aDecoder.decodeInt32(forKey: Keys.MediumDifficultyScore);
        self.hardDifficultyScore = aDecoder.decodeInt32(forKey: Keys.HardDifficultyScore);
        
        self.easyDifficulty = aDecoder.decodeBool(forKey: Keys.EasyDifficulty);
        self.mediumDifficulty = aDecoder.decodeBool(forKey: Keys.MediumDifficulty);
        self.hardDifficulty = aDecoder.decodeBool(forKey: Keys.HardDifficulty);
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encodeCInt(self.easyDifficultyScore, forKey: Keys.EasyDifficultyScore);
        aCoder.encodeCInt(self.mediumDifficultyScore, forKey: Keys.MediumDifficultyScore);
        aCoder.encodeCInt(self.hardDifficultyScore, forKey: Keys.HardDifficultyScore);
        
        aCoder.encode(self.easyDifficulty, forKey: Keys.EasyDifficulty);
        aCoder.encode(self.mediumDifficulty, forKey: Keys.MediumDifficulty);
        aCoder.encode(self.hardDifficulty, forKey: Keys.HardDifficulty);
    }
    
    // start score getters and setters
    func setEasyDifficultyScore(_ easyDifficultyScore: Int32) {
        self.easyDifficultyScore = easyDifficultyScore;
    }
    
    func getEasyDifficultyScore() -> Int32 {
        return self.easyDifficultyScore;
    }
    
  
    func setMediumDifficultyScore(_ mediumDifficultyScore: Int32) {
        self.mediumDifficultyScore = mediumDifficultyScore;
    }
    
    func getMediumDifficultyScore() -> Int32 {
        return self.mediumDifficultyScore;
    }
 
    
    func setHardDifficultyScore(_ hardDifficultyScore: Int32) {
        self.hardDifficultyScore = hardDifficultyScore;
    }
    
    func getHardDifficultyScore() -> Int32 {
        return self.hardDifficultyScore;
    }
    // end score getters and setters

  
    
    // start difficulty getters and setters
    func setEasyDifficulty(_ easyDifficulty: Bool) {
        self.easyDifficulty = easyDifficulty;
    }
    
    func getEasyDifficulty() -> Bool {
        return self.easyDifficulty;
    }
    
    
    func setMediumDifficulty(_ mediumDifficulty: Bool) {
        self.mediumDifficulty = mediumDifficulty;
    }
    
    func getMediumDifficulty() -> Bool {
        return self.mediumDifficulty;
    }
    
    
    func setHardDifficulty(_ hardDifficulty: Bool) {
        self.hardDifficulty = hardDifficulty;
    }
    
    func getHardDifficulty() -> Bool {
        return self.hardDifficulty;
    }
    // end difficulty getters and setters
    
}
