import SwiftUI

struct StockSearch: View {
    @EnvironmentObject var navigation: Navigation
    @StateObject var observer = StockSearchObserver()
    @State var searchHistory = ["banana", "ringo", "moto"]
    
    var body: some View {
        List(observer.list) { loader in
            switch loader {
            case .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            case .item(let item):
                Button(action: {
                    navigation.path.append(.stockDetail(item.name))
                }, label: {
                    VStack(alignment: .leading) {
                        Text(item.name + "22547456")
                        Text("工業用トルク3cm")
                            .font(.title2)
                    }
                })
            }
        }
        .listStyle(.grouped)
        .navigationTitle(Navigation.Path.stockSearch.title)
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $observer.searchText, placement: .navigationBarDrawer(displayMode: .always))
        .searchSuggestions {
            //検索履歴を表示
            if observer.searchText.isEmpty {
                Section("履歴") {
                    ForEach(searchHistory, id: \.self) { history in
                        Label(history, systemImage: "clock.arrow.circlepath")
                            .searchCompletion(history)
                            .swipeActions {
                                Button(role: .destructive) {
                                    searchHistory.removeAll { $0 == history }
                                } label: {
                                    Text("削除")
                                }
                            }
                    }
                }
            }
        }
        .onChange(of: observer.searchText) { _ in
            observer.fetch()
        }
        .onSubmit(of: .search) {
            if !searchHistory.contains(observer.searchText) {
                searchHistory.append(observer.searchText)
            }
            observer.fetch()
        }
    }
}

#Preview {
    NavigationStack {
        StockSearch()
    }
}
