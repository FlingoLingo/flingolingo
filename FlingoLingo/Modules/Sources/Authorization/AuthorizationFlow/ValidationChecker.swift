//
//  File.swift
//  
//
//  Created by Alexander Muratov on 4/15/23.
//

import Foundation

struct ValidationChecker {
    public static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    public static func isValidPassword(_ password: String) -> Bool {
        let passWordRegEx = "^.{8,}$"

        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passWordRegEx)
        return passwordPred.evaluate(with: password)
    }
}
