//
//  AddTaskNotesView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-08-29.
//

import SwiftUI

struct AddTaskNotesView: View {
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
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(colour, lineWidth: 1)
            )
        }
    }
}
