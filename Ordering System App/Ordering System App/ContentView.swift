//
//  ContentView.swift
//  Ordering System App
//
//  Created by hungwei on 2024/9/24.
//

import SwiftUI
import Speech
import AVFoundation



struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                // 表格項目 1，導航到 H1_ContentView
                NavigationLink(destination: H1_ContentView()) {
                    Text("CH1 頁面")
                }
                
                // 可以繼續新增更多頁面
                NavigationLink(destination: CH2_ContentView()) {
                    Text("CH2 頁面")
                }
                
                // 表格項目 2，導航到 CH3_ContentView
                NavigationLink(destination: CH3_ContentView()) {
                    Text("CH3 頁面")
                }

             
            }
            .navigationTitle("頁面選單")
        }
    }
}


#Preview {
    ContentView()
}
