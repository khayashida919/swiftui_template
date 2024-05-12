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
        .navigationTitle(Navigation.Path.stockIn.rawValue)
    }
    
    private func complete() {
        print(navigation.path)
        Task {
            navigation.isLoading = true
            try await Task.sleep(for: .seconds(2))
            navigation.isLoading = false
            try await Task.sleep(for: .seconds(2))
            navigation.isSuccessAlert = true
        }
    }
}

#Preview {
    NavigationStack {
        StockIn()
    }
}
