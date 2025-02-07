//
//  RemoveOrDeleteItemsAlert.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-02-01.
//

import SwiftUI

struct RemoveOrDeleteItemsAlert: ViewModifier {
    
    @Binding var isShowingAlert: Bool
    var removeItemAction: () -> Void
    var deleteItemAction: () -> Void
    
    func body(content: Content) -> some View {
        content
            // Add/edit alert
            .alert("Remove or delete item?", isPresented: $isShowingAlert) {
                Button("Remove item") {
                    removeItemAction()
                }
                Button("Delete item") {
                    deleteItemAction()
                }
                Button("Cancel", role: .cancel) {
                    
                }
            }
    }
}

extension View {
    func removeOrDeleteItemsAlert(
        isShowingAlert: Binding<Bool>,
        removeItemAction: @escaping () -> Void,
        deleteItemAction: @escaping () -> Void
    ) -> some View {
        modifier(RemoveOrDeleteItemsAlert(isShowingAlert: isShowingAlert, removeItemAction: removeItemAction, deleteItemAction: deleteItemAction))
    }
}

