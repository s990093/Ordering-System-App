//
//  FoodCategoryDetailView.swift
//  Ordering System App
//
//  Created by hungwei on 2024/10/22.
//

import Foundation
import SwiftUI


struct FoodCategoryDetailView: View {
    var category: String
    var foodItems: [FoodItem]
    @Binding var selectedItems: [FoodItem]
    
    @State private var showImageZoom = false
    @State private var selectedImageName = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        
        // 如果選擇了餐點類別，顯示該類別的詳細餐點資訊
        List {
                Text("點餐明細")
                    .font(.headline)
                    .foregroundColor(.gray)
                ForEach(selectedItems) { item in
                    HStack {
                        Text("\(item.name) * \(item.quantity)")
                        Spacer()
                        Text("= \(item.price * item.quantity) 元")
                    }
                }
        
            
            Section(header: Text(category)
                .font(.title2)
                .foregroundColor(.green)) {
                    ForEach(foodItems) { item in
                        HStack {
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .onLongPressGesture {
                                    selectedImageName = item.imageName
                                    showImageZoom = true
                                }
                                .sheet(isPresented: $showImageZoom) {
                                    ImageZoomView(imageName: selectedImageName)
                                }
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price)")
                            
                            // 下拉選擇數量
                            Picker("數量", selection: Binding(
                                get: {
                                    selectedItems.first(where: { $0.id == item.id })?.quantity ?? 1
                                },
                                set: { newQuantity in
                                    if let index = selectedItems.firstIndex(where: { $0.id == item.id }) {
                                        selectedItems[index].quantity = newQuantity
                                    }
                                }
                            )) {
                                ForEach(1..<11) { i in
                                    Text("\(i)").tag(i)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            
                            Button(action: {
                                // 勾選點擊
                                if let index = selectedItems.firstIndex(where: { $0.id == item.id }) {
                                    selectedItems.remove(at: index)
                                } else {
                                    var newItem = item
                                    newItem.quantity = 1
                                    selectedItems.append(newItem)
                                }
                            }) {
                                Image(systemName: selectedItems.contains(where: { $0.id == item.id }) ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(selectedItems.contains(where: { $0.id == item.id }) ? .green : .gray)
                            }
                        }
                    }
                }
            
        }
        .listStyle(InsetGroupedListStyle())
      
        // 底部加入按鈕區域
        HStack {
            Button(action: {
                // 取消操作：清空選項或跳轉
                selectedItems.removeAll()
            }) {
                Text("取消")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss() // 按下後返回上一頁

            }) {
                Text("加入清單")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
    }
 
    
}


// 圖片放大視圖
struct ImageZoomView: View {
    var imageName: String
    
    var body: some View {
        VStack {
            Spacer()
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .background(Color.black)
            Spacer()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
