import SwiftUI
import UIKit

public struct GuestProfileViewControllerFactory {
    @ObservedObject private var viewModel = UsersViewModel()

    public init() {

    }

    public func changePasswordViewController() -> UIViewController {
        return UIHostingController(rootView: GuestProfileView())
    }
}
