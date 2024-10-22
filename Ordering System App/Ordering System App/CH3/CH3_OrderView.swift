import SwiftUI

struct CH3_OrderView: View {
    @State private var customerName = ""
    @State private var customerPhone = ""
    @State private var selectedItems: [FoodItem] = []
    @State private var showCheckout = false
    @State private var totalAmount: Int = 0
    
    @State private var foodCategories: [String: [FoodItem]] = [
        "蛋餅": [FoodItem(name: "原味蛋餅", price: 20, imageName: "egg1"), FoodItem(name: "蔬菜蛋餅", price: 30, imageName: "egg2"), FoodItem(name: "起司蛋餅", price: 40, imageName: "egg3")],
        
        "鍋燒": [FoodItem(name: "鍋燒粥", price: 80, imageName: "noodle1"), FoodItem(name: "鍋燒意麵", price: 80, imageName: "noodle2"), FoodItem(name: "鍋燒雞絲", price: 80, imageName: "noodle3")],
        
        "總匯": [FoodItem(name: "豬肉總匯", price: 65, imageName: "sandwich1"), FoodItem(name: "雞肉總匯", price: 65, imageName: "sandwich2"), FoodItem(name: "里肌總匯", price: 89, imageName: "sandwich3")]
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                // 顧客資料
                CustomerInfoView(customerName: $customerName, customerPhone: $customerPhone)
                
                
                
                Text("請選擇餐點類別")
                    .font(.title2)  // 設置字體大小
                    .fontWeight(.bold)  // 設置字體粗細
                    .foregroundColor(.green)  // 設置字體顏色
                    .frame(maxWidth: .infinity, alignment: .center)  // 設置最大寬度並居中
                    .padding()  // 添加內邊距

                List {
                    ForEach(foodCategories.keys.sorted(), id: \.self) { category in
                        NavigationLink(destination: FoodCategoryDetailView(category: category, foodItems: foodCategories[category]!, selectedItems: $selectedItems)) {
                            HStack {
                                Text(category)
                                    .font(.title2)
                                    .foregroundColor(.green)
                                Spacer()
                                
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
                
                Spacer()
                
                // 點餐明細
                OrderSummaryView(customerName: customerName, selectedItems: selectedItems, totalAmount: totalAmount)
                
                // 結帳按鈕
                Button(action: {
                    showCheckout = true
                }) {
                    Text("結帳")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .onChange(of: selectedItems) { _ in
                    calculateTotalAmount() // 當選擇的餐點變更時，重新計算總金額
                }
                .sheet(isPresented: $showCheckout) {
                    CheckoutView(isCheckoutPresented: $showCheckout, totalAmount: totalAmount)
                }
            }
            
            .navigationTitle("我要點餐")
        }
        
    }
        
    // 計算總金額
    func calculateTotalAmount() {
        totalAmount = selectedItems.reduce(0) { $0 + ($1.price * $1.quantity) }
    }
}



struct CH_3OrderView_Previews: PreviewProvider {
    static var previews: some View {
        CH3_OrderView()
    }
}
