//
//  WeeklyBreakdownNotesView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-08-27.
//

import SwiftUI

// TODO: Optimize this
struct WeeklyBreakdownNotesView: View {
    @Environment(\.managedObjectContext) var moc
    var dailySchedule: DailySchedule
    @State private var text: String

    @FocusState private var isFocused: Bool
    
    init(dailySchedule: DailySchedule) {
        self.dailySchedule = dailySchedule
        self.text = dailySchedule.notes ?? ""
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                SubtitleLabel(text: "Notes")
                    .padding(.leading, 10)
                Spacer()
                Button(
                    action: {
                        saveNotes()
                        isFocused = false
                    },
                    label: {
                        Image(systemName: "doc.badge.plus")
                            .tint(CustomColours.ctaGold)
                    }
                )
            }
            VStack(spacing: 0) {
                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .padding(10)
                    .focused($isFocused)
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
    
    private func saveNotes() {
        dailySchedule.notes = text
        do {
            try moc.save()
        } catch let error {
            print(error)
        }
    }
}
