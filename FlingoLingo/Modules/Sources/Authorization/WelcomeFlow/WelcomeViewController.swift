//
//  WelcomeView.swift
//  FlingoLingo
//
//  Created by Alexander Muratov on 4/12/23.
//

import UIKit

public class WelcomeViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var welcomeView: WelcomeView = {
        
        let view = WelcomeView()
        view.delegate = self
        return view
    }()
    
    // MARK: - Lifecycle
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        
        view = welcomeView
    }
}

// MARK: - WelcomeViewDelegate
extension WelcomeViewController: WelcomeViewDelegate {
    
    func signUpButtonTapped() {
        
        print(#function)
    }
    
    func logInButtonTapped() {

        print(#function)
    }
    
    func guestLogInButtonTapped() {
        print(#function)
    }
}
