//
//  Buttons.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-04-07.
//

import SwiftUI

struct PrimaryButton: View {
    
    let text: String
    let backgroundColour: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .foregroundColor(CustomColours.textDarkGray)
                .background(backgroundColour)
                .font(CustomFonts.buttonFont)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(CustomColours.veryLightGray, lineWidth: 1)
                }
        }
    }
}

struct TextButton: View {
    
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .foregroundColor(CustomColours.textDarkGray)
                .font(CustomFonts.buttonFont)
        }
    }
}

struct ToolbarAddButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "plus")
                .tint(CustomColours.ctaGold)
        }
    }
}
