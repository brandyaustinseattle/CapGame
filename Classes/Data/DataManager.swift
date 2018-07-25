//
//  DataManager.swift
//  CapGame
//
//  Created by Brandy Austin on 7/24/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import Foundation

class DataManager {
    
    static let instance = DataManager();
    
    fileprivate init() {}
    
    fileprivate var gameData: GameData?;
    
    var gameStartedFromMainMenu = false;
    var gameRestartedPlayerDied = false;
    
    func initializeGameData() {
        
        if !FileManager.default.fileExists(atPath: getFilePath() as String) {
            // setup our game with initial values
            gameData = GameData();
            
            gameData?.setEasyDifficultyScore(0);
            gameData?.setMediumDifficultyScore(0);
            gameData?.setHardDifficultyScore(0);
            
            gameData?.setEasyDifficulty(false);
            gameData?.setMediumDifficulty(true);
            gameData?.setHardDifficulty(false);
            
            saveData();
        }
        
        loadData();
        
    }
    
    func loadData() {
        gameData = NSKeyedUnarchiver.unarchiveObject(withFile: getFilePath() as String) as? GameData?
    }
    
    func saveData() {
        if gameData != nil {
            NSKeyedArchiver.archiveRootObject(gameData!, toFile: getFilePath() as String);
        }
    }
    
    fileprivate func getFilePath() -> String {
        let manager = FileManager.default;
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first as URL?;
        return url!.appendingPathComponent("Game Data").path;
    }
    
    // start score getters and setters
    func setEasyDifficultyScore(_ easyDifficultyScore: Int32) {
        gameData!.setEasyDifficultyScore(easyDifficultyScore);
    }
    
    func getEasyDifficultyScore() -> Int32 {
        return gameData!.getEasyDifficultyScore();
    }
    
    
  
    func setMediumDifficultyScore(_ mediumDifficultyScore: Int32) {
        gameData!.setMediumDifficultyScore(mediumDifficultyScore);
    }
    
    func getMediumDifficultyScore() -> Int32 {
        return gameData!.getMediumDifficultyScore();
    }
    
  
    
    func setHardDifficultyScore(_ hardDifficultyScore: Int32) {
        gameData!.setHardDifficultyScore(hardDifficultyScore);
    }
    
    func getHardDifficultyScore() -> Int32 {
        return gameData!.getHardDifficultyScore();
    }
    // end score getters and setters

    
    
    // start difficulty getters and setters
    func setEasyDifficulty(_ easyDifficulty: Bool) {
        gameData!.setEasyDifficulty(easyDifficulty);
    }
    
    func getEasyDifficulty() -> Bool {
        return gameData!.getEasyDifficulty();
    }
    
    
    func setMediumDifficulty(_ mediumDifficulty: Bool) {
        gameData!.setMediumDifficulty(mediumDifficulty);
    }
    
    func getMediumDifficulty() -> Bool {
        return gameData!.getMediumDifficulty();
    }
    
    
    func setHardDifficulty(_ hardDifficulty: Bool) {
        gameData!.setHardDifficulty(hardDifficulty);
    }
    
    func getHardDifficulty() -> Bool {
        return gameData!.getHardDifficulty();
    }
    // end difficulty getters and setters
    
}
