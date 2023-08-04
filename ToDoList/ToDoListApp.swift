//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Chi Tim on 2023/8/4.
//

import SwiftUI

/*
    MVVM
 
 Model - data point
 View - UI
 ViewModel - manage Model for view
 
*/

@main
struct ToDoListApp: App {
    
    @StateObject var listViewModel:ListViewModel=ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ListView()
            }
            .environmentObject(listViewModel)//设置全局环境变量
        }
    }
}
