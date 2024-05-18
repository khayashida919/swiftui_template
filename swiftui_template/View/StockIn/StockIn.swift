import SwiftUI

struct StockIn: View {
    @EnvironmentObject var navigation: Navigation
    @StateObject var observer = StockInObserver()
    
    var body: some View {
        ZStack {
            List {
                ForEach(observer.list) { item in
                    HStack {
                        Text(item.key.description)
                        Text(item.count.description)
                    }
                }
                Color.clear.padding(.bottom, 32)
            }
            .listStyle(.grouped)
            
            VStack {
                Spacer()
                Button(action: complete, label: {
                    Text("スキャン")
                        .font(.headline)
                        .frame(maxWidth: .infinity, minHeight: 40)
                })
                .padding(.horizontal)
                .buttonStyle(.borderedProminent)
            }
        }
        .navigationTitle(Navigation.Path.stockIn.title)
    }
    
    private func complete() {
        Task {
            navigation.isLoading = true
            await observer.complete()
            navigation.isLoading = false
            navigation.isSuccessAlert = true
        }
    }
}

#Preview {
    NavigationStack {
        StockIn()
    }
}
