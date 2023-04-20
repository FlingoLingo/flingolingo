import Foundation
import UIKit
import Authorization

final class ProfileRouter {

    public weak var presentingViewController: UIViewController?

    func changePassword(provider: ProfileProvider) {
        // currently fixing this func
//        let user = provider.getUser()
        let changePasswordFactory = ChangePasswordViewControllerFactory()
        let changePasswordController = changePasswordFactory.changePasswordViewController(backAction: goBack,
                                                                                          provider: provider)
        presentingViewController?.navigationController?.pushViewController(changePasswordController, animated: true)
    }

    func openWelcomeScreen() {
        let welcomeViewController = WelcomeViewController(provider: ProfileProviderImpl())
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
