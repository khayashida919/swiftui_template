import SwiftUI

final class AlertContent: ObservableObject {
    @Published var isShow = false
    @Published var content: Content?
    
    struct Content {
        let title: String
        let messageView: MessageView?
        let actionView: ActionView
    }
    
    struct MessageView: View {
        var message: String
        
        var body: some View {
            Text(message)
        }
    }
    
    struct ActionView: View {
        var kind: Kind
        
        enum Kind {
            case single(text: String, action: (() -> Void)? = nil)
            case double(text: String, action: (() -> Void)? = nil, cancelAction: (() -> Void)? = nil)
        }
        
        var body: some View {
            switch kind {
            case .single(let text, let action):
                Button(text, action: action ?? {})
            case .double(let text, let action, let cancelAction):
                Button("キャンセル", action: cancelAction ?? {})
                Button(text, action: action ?? {})
            }
        }
    }
    
    func showOk(
        title: String,
        message: String? = nil,
        action: (() -> Void)? = nil
    ) {
        content = Content(
            title: title,
            messageView: message.map { MessageView(message: $0) },
            actionView: ActionView(kind: .single(
                text: "OK",
                action: action
            ))
        )
        isShow = true
    }
    
    func showCancelOk(
        title: String,
        message: String?,
        actionText: String? = nil,
        cancelAction: (() -> Void)? = nil,
        okAction: (() -> Void)? = nil
    ) {
        content = Content(
            title: title,
            messageView: message.map { MessageView(message: $0) },
            actionView: ActionView(kind: .double(
                text: actionText ?? "OK",
                action: okAction,
                cancelAction: cancelAction
            ))
        )
        isShow = true
    }
}

struct AlertView: ViewModifier {
    @ObservedObject var alertContent: AlertContent
    
    func body(content: Content) -> some View {
        content
            .alert(
                alertContent.content?.title ?? "",
                isPresented: $alertContent.isShow,
                presenting: alertContent.content,
                actions: { $0.actionView },
                message: { $0.messageView })
    }
}

extension View {
    func alert(_ alertContent: AlertContent) -> some View {
        modifier(AlertView(alertContent: alertContent))
    }
}
