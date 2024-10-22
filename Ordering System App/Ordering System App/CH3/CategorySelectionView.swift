import SwiftUI

// 類別選擇視圖
struct CategorySelectionView: View {
    let foodCategories: [String: [FoodItem]]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("請選擇餐點類別")
                    .font(.title2)
                    .foregroundColor(.green)
                    .padding()
                
                List {
                    ForEach(foodCategories.keys.sorted(), id: \.self) { category in
                        NavigationLink(destination: OrderDetailView(category: category, items: foodCategories[category]!)) {
                            HStack {
                                Text(category)
                                    .font(.title2)
                                    .foregroundColor(.green)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("類別選擇")
        }
    }
}
