//
//  Labels.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-05-31.
//

import Foundation
import SwiftUI

struct LargeTitleLabel: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(CustomFonts.largeTitleFont)
            .foregroundColor(CustomColours.textDarkGray)
    }
}

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

struct HeadingLabel: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(CustomColours.textDarkGray)
    }
}

struct SubheadingLabel: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.callout)
            .fontWeight(.regular)
            .foregroundColor(CustomColours.textDarkGray)
    }
}

struct SheetTitleLabel: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(CustomColours.textDarkGray)
    }
}
