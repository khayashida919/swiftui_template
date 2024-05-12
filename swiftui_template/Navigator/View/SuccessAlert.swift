import SwiftUI

struct SuccessAlert: View {
    @EnvironmentObject var navigation: Navigation
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.green)
                
                Text("正常に成功しました")
                    .padding()
                    .font(.headline)
                
                Spacer()
                
                Button(action: {
                    navigation.path.removeLast()
                    navigation.isSuccessAlert = false
                }, label: {
                    Text("戻る")
                        .font(.headline)
                        .frame(maxWidth: .infinity, minHeight: 40)
                })
                .buttonStyle(.borderless)
            }
            .frame(maxWidth: 240, maxHeight: 320)
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black.opacity(0.5))
    }
}

#Preview {
    SuccessAlert()
}
