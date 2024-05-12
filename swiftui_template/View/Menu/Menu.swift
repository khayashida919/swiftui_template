import SwiftUI

struct Menu: View {
    @EnvironmentObject var navigation: Navigation
    
    let columns = [GridItem](repeating: .init(.flexible()), count: 1)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(Navigation.Path.mainMenus) { menu in
                    Button(action: {
                        navigation.path.append(menu)
                    }, label: {
                        VStack(alignment: .leading) {
                            Text(menu.subTitle)
                                .font(.subheadline)
                                .opacity(0.5)
                            
                            Text(menu.rawValue)
                                .font(.largeTitle)
                                .bold()
                        }
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 120, alignment: .leading)
                    })
                    .background(.white)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.tint, lineWidth: 4))
                }
            }
            .padding()
        }
        .background(Color(UIColor.systemGroupedBackground))
//        .navigationBarBackButtonHidden()
        .navigationTitle(Navigation.Path.menu.rawValue)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("テスト太郎")
            }
        }
    }
}

#Preview {
    NavigationStack {
        Menu()
    }
}
