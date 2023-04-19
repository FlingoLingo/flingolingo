import Foundation
import UIKit
import Authorization

final class ProfileRouter {

    public weak var presentingViewController: UIViewController?

    func changePassword(user: User, provider: ProfileProvider) {
        let changePasswordFactory = ChangePasswordViewControllerFactory()
        let changePasswordController = changePasswordFactory.changePasswordViewController(user: user,
                                                                                          backAction: goBack,
                                                                                          provider: provider)
        presentingViewController?.navigationController?.pushViewController(changePasswordController, animated: true)
    }

    func openWelcomeScreen() {
        let welcomeViewController = WelcomeViewController()
        let navWelComeController = UINavigationController()
        navWelComeController.setNavigationBarHidden(true, animated: false)
        navWelComeController.viewControllers.append(welcomeViewController)
        navWelComeController.modalPresentationStyle = .fullScreen
        presentingViewController?.present(navWelComeController, animated: true, completion: nil)
    }

    private func goBack() {
        presentingViewController?.navigationController?.popViewController(animated: true)
    }
}
