import SwiftUI

struct OrderItemView: View {
    var item: FoodItem
    @State private var showImage = false
    
    var body: some View {
        HStack {
            Image(item.name)
                .resizable()
                .frame(width: 50, height: 50)
                .onTapGesture {
                    showImage.toggle()
                }
                .sheet(isPresented: $showImage) {
                    Image(item.name)
                        .resizable()
                        .scaledToFit()
                }
            
            Text(item.name)
            Spacer()
            Text("$\(item.price)")
        }
        .padding()
    }
}
