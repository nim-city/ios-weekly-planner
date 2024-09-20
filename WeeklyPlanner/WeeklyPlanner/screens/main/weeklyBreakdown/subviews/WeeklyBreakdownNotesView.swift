//
//  WeeklyBreakdownNotesView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-08-27.
//

import SwiftUI

// TODO: Optimize this
struct WeeklyBreakdownNotesView: View {
    @ObservedObject var dailySchedule: DailySchedule
    @Binding var text: String

    var isFocused: FocusState<Bool>.Binding
    
    
    init(dailySchedule: DailySchedule, isFocused: FocusState<Bool>.Binding) {
        self.dailySchedule = dailySchedule
        self.isFocused = isFocused
        
        self._text = Binding(
            get: {
                return dailySchedule.notes ?? ""
            },
            set: { newValue in
                dailySchedule.notes = newValue
            }
        )
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                SubtitleLabel(text: "Notes")
                    .padding(.leading, 10)
                Spacer()
            }
            VStack(spacing: 0) {
                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .padding(10)
                    .focused(isFocused)
            }
            .background(.white)
            .frame(
                height: 200
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        CustomColours.accentBlue,
                        lineWidth: 3
                    )
            )
            .padding(.bottom, 20)
        }
    }
}
