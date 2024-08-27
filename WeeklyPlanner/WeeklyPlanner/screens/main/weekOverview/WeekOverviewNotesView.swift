//
//  WeekOverviewNotesView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-07-17.
//

import Foundation
import SwiftUI

struct WeekOverviewNotesView: View {
    let text: String

    var body: some View {
        VStack(alignment: .leading) {
            SubtitleLabel(text: "Notes")
                .padding(.leading, 10)
            
            if text.isEmpty {
                HStack {
                    Text("No notes yet")
                        .font(CustomFonts.noNotesFont)
                        .italic()
                        .padding(10)
                    Spacer()
                }
            } else {
                HStack {
                    Text(text)
                        .padding(20)
                    Spacer()
                }
                .background(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            CustomColours.accentBlue,
                            lineWidth: 3
                        )
                )
            }
        }
    }
}
