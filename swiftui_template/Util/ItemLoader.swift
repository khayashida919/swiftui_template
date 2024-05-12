import Foundation

enum ItemLoader<T>: Identifiable {
    case loading
    case item(T)
    
    var id: UUID { UUID() }
}
