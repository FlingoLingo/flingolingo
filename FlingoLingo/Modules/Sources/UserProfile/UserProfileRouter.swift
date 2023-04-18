import Foundation
import UIKit
import Authorization

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

    func openWelcomeScreen() {
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.hidesBottomBarWhenPushed = true
        presentingViewController?.navigationController?.pushViewController(welcomeViewController, animated: true)
    }

    private func goBack() {
        presentingViewController?.navigationController?.popViewController(animated: true)
    }
}
