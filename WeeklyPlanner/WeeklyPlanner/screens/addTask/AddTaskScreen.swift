//
//  AddTaskScreen.swift
//  WeeklyPlanner
//
//  Created by Nimish Narang on 2025-02-19.
//

import SwiftUI


class AddTaskScreen {
    
    static let shared = AddTaskScreen()
    
    private var window: UIWindow?
    
    private init() {}
    
    func show(withViewModel viewModel: TaskItemViewModel) {
//        guard window == nil,
//              let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
//            return
//        }
//        
//        let hostingVC = UIHostingController(rootView: AddTaskScreen.AddTaskView(viewModel: viewModel))
//        hostingVC.view.backgroundColor = .clear
//        
//        window = UIWindow(windowScene: scene)
//        window?.rootViewController = hostingVC
//        window?.backgroundColor = .clear
//        window?.windowLevel = .alert + 1
//        window?.makeKeyAndVisible()
    }
    
    func dismiss() {
        window?.isHidden = true
        window = nil
    }
}
