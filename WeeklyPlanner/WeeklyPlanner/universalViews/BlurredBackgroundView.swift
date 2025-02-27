//
//  BlurredBackgroundView.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-02-19.
//

import SwiftUI


struct BlurredBackgroundView: UIViewRepresentable {

    func makeUIView(context: Context) -> UIVisualEffectView {
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        effectView.translatesAutoresizingMaskIntoConstraints = false
        effectView.alpha = 0.95
        return effectView
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        // Update the effect if needed, in this case we are setting the same style
    }
}
