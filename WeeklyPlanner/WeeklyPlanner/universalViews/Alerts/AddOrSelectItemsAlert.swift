//
//  AddOrSelectItemsAlert.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-02-01.
//

import SwiftUI

struct AddOrSelectItemsAlert: ViewModifier {
    
    @Binding var isShowingAlert: Bool
    var selectItemsAction: () -> Void
    var addItemsAction: () -> Void
    
    func body(content: Content) -> some View {
        content
            // Add/edit alert
            .alert("Add an item?", isPresented: $isShowingAlert) {
                Button("Select item") {
                    selectItemsAction()
                }
                Button("Add new item") {
                    addItemsAction()
                }
                Button("Cancel", role: .cancel) {
                    
                }
            }
    }
}

extension View {
    func addOrSelectItemsAlert(
        isShowingAlert: Binding<Bool>,
        selectItemsAction: @escaping () -> Void,
        addItemsAction: @escaping () -> Void
    ) -> some View {
        modifier(AddOrSelectItemsAlert(isShowingAlert: isShowingAlert, selectItemsAction: selectItemsAction, addItemsAction: addItemsAction))
    }
}
