import SwiftUI

struct OrderSummaryView: View {
    var customerName: String
    var selectedItems: [FoodItem]
    var totalAmount: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(customerName) 您好： 今天點了 \(selectedItems.count) 種餐點")
                .font(.headline)
                .foregroundColor(.gray)
            
            ForEach(selectedItems) { item in
                HStack {
                    Text("\(item.name) * \(item.quantity)")
                    Spacer()
                    Text("= \(item.price * item.quantity) 元")
                }
            }
            
            HStack {
                Text("總金額")
                    .font(.headline)
                Spacer()
                Text("$\(totalAmount) 元")
                    .font(.headline)
                    .foregroundColor(totalAmount >= 100 ? .green : .black)
            }
            
            // 顯示折扣優惠
            if totalAmount >= 100 {
                Text("已超過 100 元，享受 9 折優惠")
                    .font(.subheadline)
                    .foregroundColor(.green)
            }
        }
        .padding()
    }
}
