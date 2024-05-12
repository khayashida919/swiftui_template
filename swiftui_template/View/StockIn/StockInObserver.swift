import Foundation

@MainActor
final class StockInObserver: ObservableObject {
    @Published var list = (1...9999).map { Item(key: $0) }
    
    @Published var alert = AlertContent()
    
    func complete() {
        
    }
    
    struct Item: Identifiable {
        var id = UUID()
        let key: Int
        var count = 0
    }
}
