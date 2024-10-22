//
//  ContentView.swift
//  Ordering System App
//
//  Created by hungwei on 2024/9/24.
//

import SwiftUI

struct CH2_ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                // App title
                Text("點餐系統App")
                    .font(.largeTitle)
                    .padding()

                // Four buttons
                VStack(spacing: 20) {
                    NavigationLink(destination: OrderView()) {
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

// Custom button view
struct MenuButton: View {
    var label: String
    var imageName: String

    var body: some View {
        HStack {
            Image(systemName: imageName)
                .font(.title)
            Text(label)
                .font(.title2)
        }
        .frame(maxWidth: .infinity, minHeight: 50)
        .background(Color.yellow)
        .foregroundColor(.black)
        .cornerRadius(10)
        .padding()
    }
}



struct OrderHistoryView: View {
    var body: some View {
        Text("點餐紀錄 View")
            .font(.largeTitle)
            .navigationTitle("點餐紀錄")
    }
}

struct TeamDesignView: View {
    var body: some View {
        Text("設計團隊 View")
            .font(.largeTitle)
            .navigationTitle("設計團隊")
    }
}

struct SystemInfoView: View {
    var body: some View {
        Text("關於系統 View")
            .font(.largeTitle)
            .navigationTitle("關於系統")
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


