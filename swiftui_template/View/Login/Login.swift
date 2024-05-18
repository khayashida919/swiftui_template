import SwiftUI

struct Login: View {
    @EnvironmentObject var navigation: Navigation
    @StateObject var observer = LoginObserver()
    
    @FocusState var isFocus: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                Image("SwiftUI")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 240)
                
                VStack {
                    TextField("ID", text: $observer.userId)
                        .textFieldStyle(RoundedTextFieldStyle())
                        .font(.headline)
                        .focused($isFocus)
                    
                    Spacer()
                        .frame(height: 32)
                    
                    SecureField("パスワード", text: $observer.password)
                        .textFieldStyle(RoundedTextFieldStyle())
                        .font(.headline)
                        .focused($isFocus)
                    
                    Spacer()
                        .frame(height: 52)
                    
                    Button(action: login, label: {
                        Text("ログイン")
                            .font(.headline)
                            .frame(maxWidth: .infinity, minHeight: 40)
                    })
                    .buttonStyle(.borderedProminent)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 48)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Spacer()
            }
            .padding(24)
            .alert(observer.alert)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbar {
                ToolbarItem {
                    Button {
                        navigation.path.append(Navigation.Path.setting)
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
    
    private func login() {
        Task {
            navigation.isLoading = true
            defer { navigation.isLoading = false }
            
            isFocus = false
            guard let path = await observer.login() else { return }
            navigation.path.append(path)
        }
    }
}

#Preview {
    NavigationStack {
        Login()
    }
}
