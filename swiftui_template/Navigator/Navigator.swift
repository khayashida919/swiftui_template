import SwiftUI

final class Navigation: ObservableObject {
    @Published var path = [Path]()
    @Published var isLoading = false
    @Published var isSuccessAlert = false
    
    enum Path: String, Hashable, Identifiable {
        static var mainMenus: [Self] {
            [.stockIn, .stockFix, .stockOut, .stockSearch]
        }
        
        var id: Self { self }
        
        case login = "ログイン"
        case setting = "設定"
        case menu = "メニュー"
        
        case stockIn = "入庫"
        case stockFix = "棚卸し"
        case stockOut = "出庫"
        
        case stockSearch = "在庫検索"
        case stockDetail = "在庫詳細"
        
        var subTitle: String {
            return switch self {
            case .login: "Login"
            case .setting: "Setting"
            case .menu: "Menu"
            case .stockIn: "StockIn"
            case .stockFix: "StockFix"
            case .stockOut: "StockOut"
            case .stockSearch: "StockSearch"
            case .stockDetail: "StockDetail"
            }
        }
    }
}

struct Navigator: View {
    @StateObject var navigation = Navigation()
    
    var body: some View {
        let _ = Self._printChanges()
        NavigationStack(path: $navigation.path) {
            Login()
                .navigationDestination(for: Navigation.Path.self) { path in
                    switch path {
                    case .login: Login()
                    case .setting: Setting()
                    case .menu: Menu()
                    case .stockIn: StockIn()
                    case .stockFix: StockFix()
                    case .stockOut: Text("c")
                    case .stockSearch: StockSearch()
                    case .stockDetail: Text("stockDetail")
                    }
                }
        }
        .overlay {
            if navigation.isLoading {
                Progress()
            }
            if navigation.isSuccessAlert {
                SuccessAlert()
            }
        }
        .environmentObject(navigation)
    }
}

#Preview {
    Navigator()
}
