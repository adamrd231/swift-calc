//
//  DataModel.swift
//  adam-calc
//
//  Created by Adam Reed on 1/29/19.
//  Copyright © 2019 rdConcepts. All rights reserved.
//

import Foundation


class DataModel {
    
    var savedData = Calculator()
    
    var indexOfSelectedTimerList: Int {
        
        get {
            return UserDefaults.standard.integer(forKey: "CalculatorIndex")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "CaclulatorIndex")
        }
    }
    
    init() {
        loadCalculator()
        registerDefaults()
        handleFirstTime()
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Info.plist")
    }
    
    func saveCalculator() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(savedData)
            try data.write(to:dataFilePath(), options: Data.WritingOptions.atomic)
            
        } catch {
            print("ERRRORRR ERROR ERROR ERROR encoding calculator data")
        }
    }
    
    func loadCalculator() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                savedData = try decoder.decode(Calculator.self, from: data)
                
            } catch {
                print("ERROR Decoding items array")
            }
        }
    }
    
    func handleFirstTime() {
        let userDefaults = UserDefaults.standard
        let firstTimer = userDefaults.bool(forKey: "FirstTime")
        
        if firstTimer {
            let calculatorItem = Calculator()
            calculatorItem.answer = "Hello"
            
            userDefaults.set(false, forKey:"FirstTime")
            userDefaults.synchronize()
        }
    }
    
    func registerDefaults() {
        let dictionary: [String: Any ] = [ "CalculatorIndex": -1, "FirsTime": true ]
        UserDefaults.standard.register(defaults: dictionary)
    }
    
}
