import SwiftUI



struct OrderView: View {
    @State private var selectedItems: [FoodItem] = []
    @State private var selectedCategory: String? = nil // 當前選中的餐點類別
    
    @State private var foodCategories: [String: [FoodItem]] = [
        "蛋餅": [FoodItem(name: "原味蛋餅", price: 20, imageName: "egg1"), FoodItem(name: "蔬菜蛋餅", price: 30, imageName: "egg2"), FoodItem(name: "起司蛋餅", price: 40, imageName: "egg3")],
        "鍋燒": [FoodItem(name: "鍋燒粥", price: 80, imageName: "noodle1"), FoodItem(name: "鍋燒意麵", price: 80, imageName: "noodle2"), FoodItem(name: "鍋燒雞絲", price: 80, imageName: "noodle3")],
        "總匯": [FoodItem(name: "豬肉總匯", price: 65, imageName: "sandwich1"), FoodItem(name: "雞肉總匯", price: 65, imageName: "sandwich2"), FoodItem(name: "里肌總匯", price: 89, imageName: "sandwich3")]
    ]
    var total: Int {
        selectedItems.reduce(0) { $0 + $1.price * $1.quantity }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // 點餐明細顯示在上方
                VStack(alignment: .leading) {
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
                    Divider()
                    HStack {
                        Text("總金額")
                            .font(.headline)
                        Spacer()
                        Text("$\(total) 元")
                            .font(.headline)
                            .foregroundColor(.green)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal)

                // 指引燈
                HStack {
                    Circle()
                        .fill(selectedCategory == "總匯" ? Color.green : Color.gray)
                        .frame(width: 15, height: 15)
                    Circle()
                        .fill(selectedCategory == "蛋餅" ? Color.blue : Color.gray)
                        .frame(width: 15, height: 15)
                  
                    Circle()
                        .fill(selectedCategory == "鍋燒" ? Color.red : Color.gray)
                        .frame(width: 15, height: 15)
                }
                .padding()

                // 如果沒有選擇餐點類別，顯示類別選擇頁面
                if selectedCategory == nil {
                    VStack {
                        Text("請選擇餐點類別")
                            .font(.title2)
                            .foregroundColor(.green)
                        
                        List {
                            ForEach(foodCategories.keys.sorted(), id: \.self) { category in
                                Button(action: {
                                    selectedCategory = category // 點擊分類，進入該類別詳細頁面
                                }) {
                                    HStack {
                                        Text(category)
                                            .font(.title2)
                                            .foregroundColor(.green)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                }
                                .padding(.vertical, 5)
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                } else {
                    // 如果選擇了餐點類別，顯示該類別的詳細餐點資訊
                    List {
                        Section(header: Text(selectedCategory ?? "")
                            .font(.title2)
                            .foregroundColor(.green)) {
                            ForEach(foodCategories[selectedCategory!]!) { item in
                                HStack {
                                    Circle()
                                        .fill(Color.green)
                                        .frame(width: 10, height: 10)
                                    
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
                }
                
                Spacer()
                
                // 如果有選擇餐點類別才顯示返回按鈕
                if selectedCategory != nil {
                    Button(action: {
                        selectedCategory = nil // 返回餐點類別選擇畫面
                    }) {
                        Text("返回餐點類別")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("我要點餐")
            .background(Color(UIColor.systemGray6).edgesIgnoringSafeArea(.all))
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
