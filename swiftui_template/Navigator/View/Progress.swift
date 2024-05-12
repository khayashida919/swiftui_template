import SwiftUI

struct Progress: View {
    var body: some View {
        VStack {
            ProgressView()
                .tint(.white)
                .scaleEffect(1.5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black.opacity(0.5))
    }
}

#Preview {
    Progress()
}
