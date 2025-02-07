//
//  CollapsibleView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-01-18.
//

import SwiftUI

struct CollapsibleView<MainContent: View, TrailingContent: View>: View {
    
    let title: String
    let contentView: () -> MainContent
    let trailingView: () -> TrailingContent
    
    @State private var isExpanded = true
    
    
    init(
        title: String,
        @ViewBuilder contentView: @escaping () -> MainContent,
        @ViewBuilder trailingView: @escaping () -> TrailingContent
    ) {
        self.title = title
        self.contentView = contentView
        self.trailingView = trailingView
    }
    
    
    var body: some View {
        VStack(spacing: 16) {
            
            // Title bar
            HStack {
                
                // Title label
                SubtitleLabel(text: title)
                
                // Expand/collapse button
                Button(
                    action: {
                        withAnimation(.easeOut(duration: 0.25)) {
                            isExpanded.toggle()
                        }
                    },
                    label: {
                        Image(systemName: "chevron.right.circle")
                            .tint(CustomColours.ctaGold)
                            .rotationEffect(isExpanded ? .degrees(90) : .degrees(0))
                    }
                )
                .padding(.leading, 5)
                
                Spacer()
                
                // Trailing view if applicable (typically a button)
                trailingView()
            }
            
            // Main content
            if isExpanded {
                contentView()
            }
        }
    }
}


extension CollapsibleView where TrailingContent == EmptyView {
    init(title: String, @ViewBuilder mainContent: @escaping () -> MainContent) {
        self.init(title: title, contentView: mainContent, trailingView: { EmptyView() })
    }
}
