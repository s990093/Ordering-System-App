//
//  ContentView.swift
//  Ordering System App
//
//  Created by hungwei on 2024/9/24.
//

import SwiftUI

struct CH3_ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                // App title
                Text("點餐系統App")
                    .font(.largeTitle)
                    .padding()

                // Four buttons
                VStack(spacing: 20) {
                    NavigationLink(destination: CH3_OrderView()) {
                        MenuButton(label: "我要點餐", imageName: "fork.knife")
                    }

                    NavigationLink(destination: OrderHistoryView()) {
                        MenuButton(label: "點餐紀錄", imageName: "doc.text")
                    }

                    NavigationLink(destination: TeamDesignView()) {
                        MenuButton(label: "設計團隊", imageName: "person.2")
                    }

                    NavigationLink(destination: SystemInfoView()) {
                        MenuButton(label: "關於系統", imageName: "info.circle")
                    }
                }
                .padding()
            }
        }
    }
}
