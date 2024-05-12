import Foundation

@MainActor
final class LoginObserver: ObservableObject {
    @Published var userId = "a"
    @Published var password = "a"

    @Published var alert = AlertContent()
    
    func login() async -> Navigation.Path? {
        guard !userId.isEmpty, !password.isEmpty else {
            alert.showOk(title: "ユーザIDまたはパスワードを入力してください")
            return nil
        }
        
        do {
            try await Task.sleep(for: .seconds(1))
            return .menu
        } catch {
            alert.showOk(title: error.localizedDescription)
            return nil
        }
    }
    
}
