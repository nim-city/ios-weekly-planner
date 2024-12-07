////
////  SnappingScrollView.swift
////  WeeklyPlanner
////
////  Created by Nimish Narang on 2024-12-06.
////
//
//import SwiftUI
//
//
//struct SnappingScrollView: View {
//    
//    @State private var currentSubviewIndex: Int = 0
//    @State private var dragAmount: CGFloat = 0
//    
//    private let offsetInterval = UIScreen.main.bounds.size.width
//    
//    @State var subviews: [AnyView]
//    var goToNextScreen: () -> Void
//    var goToPreviousScreen: () -> Void
//    
//    private var xOffset: CGFloat {
//        (-(CGFloat(currentSubviewIndex) * offsetInterval)) + dragAmount
//    }
//    
//    
//    var body: some View {
//        HStack(spacing: 0) {
//            ForEach(subviews, id: \.self) { subview in
//                subview
//            }
//        }
//        
//        // Size and positioning
//        .frame(
//            minWidth: 0,
//            maxWidth: offsetInterval * 7,
//            minHeight: 0,
//            maxHeight: .infinity,
//            alignment: .leading
//        )
//        .offset(x: xOffset)
//        
//        // Drag gestures
//        .gesture(
//            DragGesture()
//                .onChanged { dragValue in
//                    dragChanged(dragValue: dragValue)
//                }
//                .onEnded { dragValue in
//                    dragEnded(dragValue: dragValue)
//                }
//        )
//    }
//    
//    
//    private func dragChanged(dragValue: DragGesture.Value) {
//        // Dismiss keyboard
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//        
//        dragAmount = dragValue.translation.width
//        
//        if currentSubviewIndex == 0 {
//            if dragAmount > 0 {
//                dragAmount = dragValue.translation.width / 2
//                
//            }
//            
//        } else if currentSubviewIndex == 6 {
//            if dragAmount < 0 {
//                dragAmount = dragValue.translation.width / 2
//                
//            }
//        }
//    }
//    
//    
//    private func dragEnded(dragValue: DragGesture.Value) {
//        // Dismiss keyboard
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//        
//        // Pan screen left or right if appropriate
//        withAnimation(.easeOut) {
//            if dragValue.translation.width < -100 {
//                currentSubviewIndex += 1
//                goToNextScreen()
//                
//            } else if dragValue.translation.width > 100 {
//                currentSubviewIndex -= 1
//                goToPreviousScreen()
//            }
//            
//            dragAmount = 0
//        }
//    }
//}
