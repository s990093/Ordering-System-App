import SwiftUI



struct CustomerInfoView: View {
    @Binding var customerName: String
    @Binding var customerPhone: String
    @State private var showAlert = false
    
    // 檢查是否為有效的電話號碼
    var isValidPhone: Bool {
        return customerPhone.count == 10 && customerPhone.allSatisfy { $0.isNumber }
    }
    
    var body: some View {
        VStack {
            TextField("請輸入姓名", text: $customerName)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal)
                .onChange(of: customerName) { newValue in
                    validateInputs()
                }
            
            TextField("請輸入電話號碼", text: $customerPhone)
                .keyboardType(.numberPad)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal)
                .onChange(of: customerPhone) { newValue in
                    validateInputs()
                }
            
            // 顯示錯誤訊息
            if showAlert {
                Text("請確認輸入完整的姓名和10位數電話")
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }
    
    // 檢查輸入的格式
    private func validateInputs() {
        if customerName.isEmpty || !isValidPhone {
            showAlert = true
        } else {
            showAlert = false
        }
    }
}

