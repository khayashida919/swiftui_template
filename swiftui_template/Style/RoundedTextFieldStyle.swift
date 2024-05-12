import SwiftUI

struct RoundedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.headline)
            .frame(minHeight: 44)
            .padding(.horizontal, 16)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.secondary.opacity(0.25), lineWidth: 1))
    }
    
    class Mock {
        @State var text = ""
    }
}

#Preview {
    TextField("Sample", text: RoundedTextFieldStyle.Mock().$text)
        .textFieldStyle(RoundedTextFieldStyle())
        .padding()
}
