//
//  CustomTabBarController.swift
//  FlingoLingo
//
//  Created by Алиса Вышегородцева on 15.04.2023.
//

import UIComponents
import Decks
import UIKit

final class CustomTabBarController: UITabBarController {
    // MARK: - Constants
    private enum Constants {
        static let dictionary = UIImage(named: "dictTabItem")
        static let decks = UIImage(named: "decksTabItem")
        static let profile = UIImage(named: "profileTabItem")
    }

    // MARK: - Loads
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        configureAppearance()
        selectedIndex = 1
    }

    // MARK: - Configurations
    private func configureTabBar() {
        let dictionaryController = configureViewController(
            controller: UIViewController(),
            title: NSLocalizedString("dictionary", comment: ""),
            image: Constants.dictionary ?? .add
        )

        let decksViewController = createDecksNavigationController()

        let profileController = configureViewController(
            controller: UIViewController(),
            title: NSLocalizedString("profile", comment: ""),
            image: Constants.profile ?? .add
        )
        viewControllers = [dictionaryController, decksViewController, profileController]
    }

    private func configureAppearance() {
        tabBar.tintColor = ColorScheme.mainText
        tabBar.unselectedItemTintColor = ColorScheme.inactive
        tabBar.backgroundColor = ColorScheme.background
        tabBar.isTranslucent = false
    }

    private func createDecksNavigationController() -> UIViewController {
        let decksViewControllerFactory = DecksViewControllerFactory()
        let decksController = configureViewController(
            controller: decksViewControllerFactory.decksViewController(),
            title: NSLocalizedString("decksHeader", comment: ""),
            image: Constants.decks ?? .add
        )

        let decksNavigationController = UINavigationController(rootViewController: decksController)
        decksNavigationController.isNavigationBarHidden = true
        return decksNavigationController

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
