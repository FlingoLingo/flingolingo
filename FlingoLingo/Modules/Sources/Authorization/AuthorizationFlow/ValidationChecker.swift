//
//  File.swift
//  
//
//  Created by Alexander Muratov on 4/15/23.
//

import Foundation

struct ValidationChecker {
    func isValidEmail(_ email: String?) -> Bool {
        guard let email = email else { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    func isValidPassword(_ password: String?) -> Bool {
        guard let password = password else { return false }
        return password.count >= 8
    }
}
