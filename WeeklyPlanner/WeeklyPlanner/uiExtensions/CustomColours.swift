//
//  CustomColors.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-05-29.
//

import Foundation
import SwiftUI

class CustomColours {
    
    // Basic theme colours V1
    static let veryLightGray = Color(red: 0/255, green: 0/255, blue: 0/255).opacity(0.1)
    static let mediumLightGray = Color(red: 0/255, green: 0/255, blue: 0/255).opacity(0.2)
    static let darkGray = Color(red: 0/255, green: 0/255, blue: 0/255).opacity(0.8)
    static let textDarkGray = Color(red: 65/255, green: 65/255, blue: 65/255)
    static let accentBlue = Color(red: 29/255, green: 133/255, blue: 193/255)
    static let ctaGold = Color(red: 143/255, green: 110/255, blue: 1/255)
    static let white = Color(red: 255/255, green: 255/255, blue: 255/255)
    
    static func getBackgroundColourForTaskType(_ taskType: TaskType) -> Color {
        switch taskType {
        case .goal:
            return Color(red: 237/255, green: 120/255, blue: 9/255).opacity(0.5)
        case .toDo:
            return Color(red: 17/255, green: 141/255, blue: 242/255).opacity(0.5)
        case .toBuy:
            return Color(red: 50/255, green: 168/255, blue: 82/255).opacity(0.6)
        case .meal:
            return Color(red: 240/255, green: 24/255, blue: 53/255).opacity(0.5)
        case .workout:
            return Color(red: 163/255, green: 41/255, blue: 240/255).opacity(0.4)
        }
    }
    
    // Weekday colours
//    static let mondayColours = WeekdayColourScheme(
//        foregroundColour: .white,
//        backgroundColour: Color(red: 0/255, green: 0/255, blue: 0/255).opacity(0.05)
//    )
//    static let tuesdayColours = WeekdayColourScheme(
//        foregroundColour: .white,
//        backgroundColour: Color(red: 255/255, green: 0/255, blue: 0/255).opacity(0.2)
//    )
//    static let wednesdayColours = WeekdayColourScheme(
//        foregroundColour: .white,
//        backgroundColour: Color(red: 0/255, green: 255/255, blue: 0/255).opacity(0.2)
//    )
//    static let thursdayColours = WeekdayColourScheme(
//        foregroundColour: .white,
//        backgroundColour: Color(red: 255/255, green: 255/255, blue: 0/255).opacity(0.2)
//    )
//    static let fridayColours = WeekdayColourScheme(
//        foregroundColour: .white,
//        backgroundColour: Color(red: 0/255, green: 0/255, blue: 255/255).opacity(0.2)
//    ) // blue
//    static let saturdayColours = WeekdayColourScheme(
//        foregroundColour: .white,
//        backgroundColour: Color(red: 255/255, green: 0/255, blue: 255/255).opacity(0.2)
//    )
//    static let sundayColours = WeekdayColourScheme(
//        foregroundColour: .white,
//        backgroundColour: Color(red: 255/255, green: 128/255, blue: 0/255).opacity(0.2)
//    )
    
    private init() {}
}

struct WeekdayColourScheme {
    let foregroundColour: Color
    let backgroundColour: Color
}
