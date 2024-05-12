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
                    .frame(height: 320)
                
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
                    .frame(height: 48)
                
                Button(action: login, label: {
                    Text("ログイン")
                        .font(.headline)
                        .frame(maxWidth: .infinity, minHeight: 40)
                })
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            .padding(32)
            .alert(observer.alert)
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
