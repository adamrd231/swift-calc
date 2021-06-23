//
//  ButtonStyles.swift
//  adamsCalc
//
//  Created by Adam Reed on 6/21/21.
//

import SwiftUI

    struct NumberPadButtonStyle: ButtonStyle {
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .frame(width: 35, height: 15, alignment: .center)
                .padding()
                .background(Color(.black))
                .cornerRadius(35.0)
            
        }
    }
    
    
    struct SavedAnswersButtonStyle: ButtonStyle {
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .frame(width: 60, height: 15, alignment: .center)
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(35.0)
                .font(.subheadline)
            
        }
    }
    



