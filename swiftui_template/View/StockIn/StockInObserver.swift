import Foundation

@MainActor
final class StockInObserver: ObservableObject {
    @Published var list = (1...9999).map { Item(key: $0) }
    
    @Published var alert = AlertContent()
    
    func complete() async {
        do {
            try await Task.sleep(for: .seconds(2))
        } catch {
            alert.showOk(title: error.localizedDescription)
        }
    }
    
    struct Item: Identifiable {
        var id = UUID()
        let key: Int
        var count = 0
    }
}
