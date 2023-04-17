import SwiftUI

public struct PasswordTextField: View {

    private let placeholder: String

    @Binding public var password: String
    @State private var isSecured: Bool = true
    @State var isPasswordIncorrect: Bool

    private var placeholderColor: Color {
        password.isEmpty ? SColors.inactive : SColors.mainText
    }

    public init(placeholder: String, password: Binding<String>, isSecured: Bool = true, isPasswordIncorrect: Bool) {
        self.placeholder = placeholder
        self.isSecured = isSecured
        self._password = password
        self.isPasswordIncorrect = isPasswordIncorrect
    }

    public var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField("", text: $password)
                        .placeholder(when: password.isEmpty) {
                            Text(placeholder).foregroundColor(placeholderColor)
                        }
                        .font(Font(Fonts.searchText))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .foregroundColor(placeholderColor)
                        .autocapitalization(.none)
                        .frame(height: 45)
                } else {
                    TextField("", text: $password)
                        .placeholder(when: password.isEmpty) {
                            Text(placeholder).foregroundColor(placeholderColor)
                        }
                        .font(Font(Fonts.searchText))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .foregroundColor(placeholderColor)
                        .autocapitalization(.none)
                        .frame(height: 45)
                }
            }

            Button(action: {
                isSecured.toggle()
            }, label: {
                (self.isSecured ? Icons.eyeSlash : Icons.eye)
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
