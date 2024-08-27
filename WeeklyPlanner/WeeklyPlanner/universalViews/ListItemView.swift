//
//  ListItemView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2024-06-04.
//

import Foundation
import SwiftUI

struct ItemsListItemView: View {
    var listItem: ListItem
    
    var body: some View {
        HStack {
            Text(listItem.name ?? "Item name")
                .padding(.leading, 20)
                .foregroundColor(CustomColours.textDarkGray)
                .fontWeight(.medium)
            Spacer()
            Button(
                action: {
                    // TODO: Delete item
                },
                label: {
                    Image(systemName: "trash")
                        .tint(CustomColours.ctaGold)
                }
            )
            .padding(.trailing, 20)
        }
        .frame(height: 60)
    }
}

//struct ItemsListView: View {
//
//}
