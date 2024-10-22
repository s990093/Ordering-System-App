import SwiftUI

// 餐點詳細頁面
struct OrderDetailView: View {
    let category: String
    let items: [FoodItem]
    
    @State private var selectedItems: [FoodItem] = []
    
    var body: some View {
        VStack {
            Text("\(category) - 點餐")
                .font(.title2)
                .foregroundColor(.green)
                .padding()
            
            List {
                ForEach(items) { item in
                    HStack {
                        Text(item.name)
                        Spacer()
                        Text("$\(item.price)")
                        
                        Button(action: {
                            // 勾選點擊邏輯
                            if let index = selectedItems.firstIndex(where: { $0.id == item.id }) {
                                selectedItems.remove(at: index)
                            } else {
                                selectedItems.append(item)
                            }
                        }) {
                            Image(systemName: selectedItems.contains(where: { $0.id == item.id }) ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(selectedItems.contains(where: { $0.id == item.id }) ? .green : .gray)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            
            Spacer()
            
            // 返回按鈕
            Button(action: {
                // 返回操作
                // 可以根據需要在這裡加入自定義邏輯，或者使用內建的返回功能
            }) {
                Text("確定")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}
