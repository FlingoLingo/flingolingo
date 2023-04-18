import Foundation
import UIKit

public final class UserProfileRouter {

    public weak var presentingViewController: UIViewController?

    public init() {

    }

    func changePassword(user: User) {
        let changePasswordFactory = ChangePasswordViewControllerFactory()
        let changePasswordController = changePasswordFactory.changePasswordViewController(user: user,
                                                                                          backAction: goBack)
        presentingViewController?.navigationController?.pushViewController(changePasswordController, animated: true)
    }

    private func goBack() {
        presentingViewController?.navigationController?.popViewController(animated: true)
    }
}
