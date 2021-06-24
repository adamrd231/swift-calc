//
//  adamsCalcApp.swift
//  adamsCalc
//
//  Created by Adam Reed on 6/17/21.
//

import SwiftUI
import GoogleMobileAds

@main
struct adamsCalcApp: App {
    
    var calculator = Calculator()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(calculator)
        }
    }
}
