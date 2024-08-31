//
//  AddTaskNameInput.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-08-29.
//

import SwiftUI

struct AddTaskNameInput: View {
    @Binding var itemName: String
    var isFocused: FocusState<Bool>.Binding
    let colour: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            SubtitleLabel(text: "Name")
                .padding(.leading, 10)
            HStack {
                TextField(
                    "Task name",
                    text: $itemName
                )
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .focused(isFocused)
                .foregroundStyle(CustomColours.textDarkGray)
                .font(CustomFonts.textInputFont)
            }
            .frame(height: 50)
            .background(colour.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(colour, lineWidth: 4)
            )
        }
    }
}
