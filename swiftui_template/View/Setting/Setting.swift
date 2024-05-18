import SwiftUI

struct Setting: View {
    var body: some View {
        Form {
            HStack {
                Text("アプリバージョン")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("1.0.0")
            }
        }
        .navigationTitle(Navigation.Path.setting.title)
    }
}

#Preview {
    NavigationStack {
        Setting()
    }
}
