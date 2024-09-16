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
        VStack(alignment: .leading) {
            SubtitleLabel(text: "Notes")
                .padding(.leading, 10)
            VStack(spacing: 0) {
                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .padding(10)
                    .focused(isFocused)
                    .font(CustomFonts.textInputFont)
            }
            .background(colour.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .frame(height: 200)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(colour, lineWidth: 4)
            )
        }
    }
}
