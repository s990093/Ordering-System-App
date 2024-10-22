import SwiftUI


import SwiftUI

struct CheckoutView: View {
    @Binding var isCheckoutPresented: Bool
    var totalAmount: Int
    @State private var showConfirmation = false
    @State private var showSuccessMessage = false

    var body: some View {
        VStack {
            Image("success")  // 使用您指定的成功圖示
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)  // 設定圖示大小
                .foregroundColor(.green)
            
            Text("總金額：$\(totalAmount) 元")
                .font(.title)
                .padding()
            
            Button(action: {
                showConfirmation = true
            }) {
                Text("結帳")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            .alert(isPresented: $showConfirmation) {
                Alert(
                    title: Text("確認購買"),
                    message: Text("確定要進行購買嗎？"),
                    primaryButton: .default(Text("確定")) {
                        // 確認購買邏輯
                        showSuccessMessage = true
                    },
                    secondaryButton: .cancel(Text("取消"))
                )
            }
        }
        .padding()
        .overlay(
            // 當顯示成功消息時，顯示另一個視圖
            Group {
                if showSuccessMessage {
                    Color.black.opacity(0.5)  // 半透明背景
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 20) {
                        Text("購買成功")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("您的訂單已成功購買，請耐心等候 10 到 15 分鐘。")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding()
                        
                        Button(action: {
                            // 當按下 "好" 時，關閉結帳視圖
                            isCheckoutPresented = false
                            showSuccessMessage = false  // 關閉成功消息
                        }) {
                            Text("好")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                    }
                    .frame(maxWidth: 300)  // 設定彈窗最大寬度
                    .background(Color.black)
                    .cornerRadius(15)
                    .shadow(radius: 20)
                }
            }
        )
    }
}
