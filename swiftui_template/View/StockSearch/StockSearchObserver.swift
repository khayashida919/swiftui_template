import Foundation

@MainActor
final class StockSearchObserver: ObservableObject {
    @Published var searchText = String()
    @Published var list = (1...100).map { ItemLoader.item(Box(name: $0.description)) }

    @Published var alert = AlertContent()
    
    private var task: Task<Void, Never>?
    
    func fetch() {
        task?.cancel()
        task = Task {
            list = [.loading]
            do {
                try await Task.sleep(for: .seconds(3))
                list = (200...300).map { ItemLoader.item(Box(name: $0.description)) }
            } catch {
                alert.showOk(title: error.localizedDescription)
            }
        }
    }
    
}

struct Box {
    let name: String
}
