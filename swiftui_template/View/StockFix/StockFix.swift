import SwiftUI

struct StockFix: View {
    @StateObject var observer = StockFixObserver()
    
    var body: some View {
        ZStack {
            List {
                ForEach(observer.list) { item in
                    HStack {
                        Text(item.key.description)
                        Text(item.isScan ? "済み" : "")
                        Text(item.count.description)
                    }
                }
                Color.clear.padding(.bottom, 32)
            }
            .listStyle(.grouped)
            
            VStack {
                Spacer()
                Button(action: { observer.scan() }, label: {
                    Text("スキャン")
                        .font(.headline)
                        .frame(maxWidth: .infinity, minHeight: 40)
                })
                .padding(.horizontal)
                .buttonStyle(.borderedProminent)
            }
        }
        .navigationTitle(Navigation.Path.stockFix.rawValue)
    }
}

#Preview {
    NavigationStack {
        StockFix()
    }
}
