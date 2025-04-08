//
//  TextInputWithUnderline.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-04-06.
//

import SwiftUI

struct TextInputWithUnderline: View {
    @Binding var itemName: String
    var isFocused: FocusState<Bool>.Binding
    let colour: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                TextField(
                    "Task name",
                    text: $itemName
                )
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .focused(isFocused)
                .foregroundStyle(CustomColours.textDarkGray)
                .font(CustomFonts.textInputFont)
                .tint(CustomColours.textMediumGray)
            }
            
            Divider()
                .frame(height: 2)
                .background(colour)
                .padding(.horizontal, 5)
        }
        .frame(height: 45)
        .background(colour.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

struct TextInputWithBorder: View {
    
    @Binding var itemName: String
    var isFocused: FocusState<Bool>.Binding
    let colour: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextField(
                "Task name",
                text: $itemName
            )
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .focused(isFocused)
            .foregroundStyle(CustomColours.textDarkGray)
            .font(CustomFonts.textInputFont)
            .tint(CustomColours.textMediumGray)
        }
        .frame(height: 45)
        .background(colour.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(colour, lineWidth: 1)
        )
    }
}

struct MultilineTextInputWithBorder: View {
    
    @Binding var text: String
    var isFocused: FocusState<Bool>.Binding
    let colour: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Notes")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(CustomColours.textDarkGray)
                .padding(.leading, 5)
            
            VStack {
                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .focused(isFocused)
                    .font(CustomFonts.textInputFont)
                    .tint(CustomColours.textMediumGray)
            }
            .background(colour.opacity(0.3))
            .frame(height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(colour, lineWidth: 1)
            )
        }
    }
}
