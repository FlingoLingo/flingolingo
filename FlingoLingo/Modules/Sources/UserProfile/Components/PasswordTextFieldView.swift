import SwiftUI
import UIComponents

struct PasswordTextField: View {

    public var placeholder: String

    @State private var password: String = ""
    @State private var isSecured: Bool = true

    private var isTextEmpty: Color {
        password.isEmpty ? Color(ColorScheme.inactive) : Color(ColorScheme.mainText)
    }

    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField("", text: $password)
                        .placeholder(when: password.isEmpty) {
                            Text(placeholder).foregroundColor(Color(ColorScheme.inactive))
                        }
                        .font(Font(Fonts.searchText))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .foregroundColor(Color(ColorScheme.mainText))
                } else {
                    TextField("", text: $password)
                        .placeholder(when: password.isEmpty) {
                            Text(placeholder).foregroundColor(Color(ColorScheme.inactive))
                        }
                        .font(Font(Fonts.searchText))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .foregroundColor(Color(ColorScheme.mainText))
                }
            }

            Button(action: {
                isSecured.toggle()
            }, label: {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray)
                    .padding(.trailing, 15)
            })

        }
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
