//
//  CustomTabBarController.swift
//  FlingoLingo
//
//  Created by Алиса Вышегородцева on 15.04.2023.
//

import UIComponents
import Decks
import UIKit
import UserProfile
import Dictionary
import Authorization

final class CustomTabBarController: UITabBarController {
    // MARK: - Constants
    private enum Constants {
        static let dictionary = UIImage(named: "dictTabItem")
        static let decks = UIImage(named: "decksTabItem")
        static let profile = UIImage(named: "profileTabItem")
    }

    // MARK: - Properties
    let profileProvider = ProfileProviderImpl()

    // MARK: - Loads
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        configureAppearance()
        selectedIndex = 1
    }

    override func viewWillAppear(_ animated: Bool) {
        if !profileProvider.isUserAuthenticated() {
            let welcomeViewController = WelcomeViewController()
            let navWelComeController = UINavigationController()
            navWelComeController.setNavigationBarHidden(true, animated: false)
            navWelComeController.viewControllers.append(welcomeViewController)
            navWelComeController.modalPresentationStyle = .fullScreen
            self.present(navWelComeController, animated: true, completion: nil)
        }
    }

    // MARK: - Configurations
    private func configureTabBar() {
        let dictionaryController = createDictionaryNavigationController()

        let decksViewController = createDecksNavigationController()

        let profileController = createProfileNavigationController()

        viewControllers = [dictionaryController, decksViewController, profileController]
    }

    private func configureAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = ColorScheme.background
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance

        tabBar.tintColor = ColorScheme.mainText
        tabBar.unselectedItemTintColor = ColorScheme.inactive
        tabBar.isTranslucent = false
        tabBar.clipsToBounds = true
    }

    private func createDictionaryNavigationController() -> UIViewController {
        let dictionaryController = configureViewController(
            controller: DictionaryViewController(),
            title: NSLocalizedString("dictionary", comment: ""),
            image: Constants.dictionary ?? .add
        )

        let dictionaryNavigationController = UINavigationController(rootViewController: dictionaryController)
        dictionaryNavigationController.setNavigationBarHidden(true, animated: false)
        return dictionaryNavigationController
    }

    private func createDecksNavigationController() -> UIViewController {
        let decksViewControllerFactory = DecksViewControllerFactory()
        let decksController = configureViewController(
            controller: decksViewControllerFactory.decksViewController(),
            title: NSLocalizedString("decksHeader", comment: ""),
            image: Constants.decks ?? .add
        )

        let decksNavigationController = UINavigationController(rootViewController: decksController)
        decksNavigationController.setNavigationBarHidden(true, animated: false)
        return decksNavigationController

    }

    private func createProfileNavigationController() -> UIViewController {
        let userProfileViewControllerFactory = ProfileViewControllerFactory()
        let userProfileController = configureViewController(
            controller: userProfileViewControllerFactory.profileViewController(provider: profileProvider),
            title: NSLocalizedString("profile", comment: ""),
            image: Constants.profile ?? .add
        )

        let userProfileNavigationController = UINavigationController(rootViewController: userProfileController)
        userProfileController.navigationController?.setNavigationBarHidden(true, animated: false)
        return userProfileNavigationController
    }

    // MARK: - Generation
    private func configureViewController(
        controller: UIViewController,
        title: String,
        image: UIImage
    ) -> UIViewController {
        controller.tabBarItem.title = title
        controller.tabBarItem.image = image
        return controller
    }
}
