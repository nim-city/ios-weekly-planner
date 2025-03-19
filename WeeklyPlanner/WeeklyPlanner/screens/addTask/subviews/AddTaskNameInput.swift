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
