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
            HStack {
                Text(
                    text.isEmpty ? "No notes yet!" : text
                )
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
