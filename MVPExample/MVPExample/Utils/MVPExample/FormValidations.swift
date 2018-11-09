//
//  FormValidations.swift
//  MVPExample
//
//  Created by Pablo Dominé on 28/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import Foundation

class FormValidations {

    private enum Constants {
        static let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
            "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
            "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        static let phoneRegEx = "^((\\+)|(00))[0-9]{6,14}$" // Local: ^[0-9]{6,14}$
        static let pincodeRegEx = "^[0-9]{6}$"
        static let bikePincodeRegEx = "^[0-9]{8}$"
        static let passwordRegEx = "^.{6,12}$"
        static let nameRegEx = "^.{1,60}$"
    }
    /// Validate email string
    ///
    /// - parameter email: A String that rappresent an email address
    ///
    /// - returns: A Boolean value indicating whether an email is valid.
    static func isValid(email: String?) -> Bool {
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", Constants.emailRegEx)
        return emailTest.evaluate(with: email)
    }

    /// Validate phone number string
    ///
    /// - parameter phone number: A String that rappresent a phone number
    ///
    /// - returns: A Boolean value indicating whether a phone number is valid.
    static func isValid(phoneNumber: String) -> Bool {
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", Constants.phoneRegEx)
        return phoneTest.evaluate(with: phoneNumber)
    }

    /// Validate pincode string
    ///
    /// - parameter pincode: A String that rappresent a pincode
    ///
    /// - returns: A Boolean value indicating whether a pincode is valid.
    static func isValid(pincode: String) -> Bool {
        let pincodeTest = NSPredicate(format: "SELF MATCHES %@", Constants.pincodeRegEx)
        return pincodeTest.evaluate(with: pincode)
    }

    static func isValid(bikePincode: String) -> Bool {
        let pincodeTest = NSPredicate(format: "SELF MATCHES %@", Constants.bikePincodeRegEx)
        return pincodeTest.evaluate(with: bikePincode)
    }

    static func isValid(password: String) -> Bool {
//        https://stackoverflow.com/questions/39284607/how-to-implement-a-regex-for-password-validation-in-swift
//        ^                         Start anchor
//        (?=.*[A-Z].*[A-Z])        Ensure string has two uppercase letters.
//        (?=.*[!@#$&*])            Ensure string has one special case letter.
//        (?=.*[0-9].*[0-9])        Ensure string has two digits.
//        (?=.*[a-z].*[a-z].*[a-z]) Ensure string has three lowercase letters.
//        .{8}                      Ensure string is of length 8.
//        $

        let passwordTest = NSPredicate(format: "SELF MATCHES %@", Constants.passwordRegEx)
        return passwordTest.evaluate(with: password)
    }

    static func isValid(password: String , confirmPassword : String) -> Bool {
        if password == confirmPassword {
            return true
        } else {
            return false
        }
    }

    static func isValid(name: String) -> Bool {
        let nameTest = NSPredicate(format: "SELF MATCHES %@", Constants.nameRegEx)
        return nameTest.evaluate(with: name)
    }

}
