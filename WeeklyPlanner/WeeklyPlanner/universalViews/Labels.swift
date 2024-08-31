//
//  Labels.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-05-31.
//

import Foundation
import SwiftUI

struct ScreenTitleLabel: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(CustomFonts.screenTitleFont)
            .foregroundColor(CustomColours.textDarkGray)
    }
}

struct SubtitleLabel: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(CustomColours.textDarkGray)
    }
}
