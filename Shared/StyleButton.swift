//
//  StyleButton.swift
//  FindAR
//
//  Created by Dev Patel on 2/11/22.
//

import SwiftUI

struct StyleButton: ButtonStyle {
    var color: Color
    var forgroundColor: Color

    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.horizontal,20)
            .padding(10)
            .background(color)
            .foregroundColor(forgroundColor)
            .cornerRadius(5)
            .frame(width:70, height:30)
//            .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
//            .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
    
}

extension Color {
    static let lightShadow = Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)
    static let darkShadow = Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255)
    static let background = Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255)
}
