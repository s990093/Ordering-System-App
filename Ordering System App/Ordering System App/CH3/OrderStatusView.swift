import SwiftUI

struct OrderStatusView: View {
    var selectedCategory: String?
    
    var body: some View {
        Text("您正在點 \(selectedCategory ?? "餐點") 類")
            .font(.headline)
            .foregroundColor(.gray)
            .padding()
    }
}
