//
//  WeekOverviewNotesView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-07-17.
//

import SwiftUI

struct WeekOverviewNotesView: View {
    @Binding var text: String
    var isFocused: FocusState<Bool>.Binding
    

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
                minHeight: 50,
                maxHeight: 200
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
