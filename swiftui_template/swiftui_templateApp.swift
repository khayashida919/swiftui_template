import SwiftUI

@main
struct swiftui_templateApp: App {
    var body: some Scene {
        WindowGroup {
            Navigator()
                .onAppear {
                    UITableView.appearance().sectionHeaderTopPadding = 0
                }
        }
    }
}
