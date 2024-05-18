import Foundation

@MainActor
final class StockFixObserver: ObservableObject {
    @Published var list = (1...9999).map { Item(key: $0) }
    
    @Published var alert = AlertContent()
    
    func scan() {
        (1...9999).forEach { key in
            let index = list.firstIndex(where: { item in item.key == key })
            if let index {
                list[index].isScan = true
                list[index].count += 1
            }
        }
    }
    
    struct Item: Identifiable {
        let id = UUID()
        let key: Int
        var isScan = false
        var count = 0
    }
}
