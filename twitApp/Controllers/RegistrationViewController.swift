//
//  RegistrationViewController.swift
//  twitApp
//
//  Created by Dayana Marden on 15.04.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    let authService = AuthenticationService()
    lazy var logoView: LogoView = {
        let v = LogoView()
        v.center = self.view.center
        v.frame = CGRect(x: 0, y: 16, width: 200, height: 100)
        v.center.x = self.view.center.x
        v.backgroundColor = .clear
        v.subname.text = "Registration"
        return v
    }()
    lazy var nameTextField: TextField = {
        let textField = TextField()
        textField.frame.origin = CGPoint(x: self.view.center.x , y: self.logoView.frame.maxY)
        textField.frame.size = CGSize(width: self.view.frame.width - 64, height: self.view.frame.height/12)
        textField.center.x = self.view.center.x
        textField.placeholder = "Name"
        return textField
    }()
    lazy var surnameTextField: TextField = {
        let textField = TextField()
        textField.frame.origin = CGPoint(x: self.view.center.x , y: self.nameTextField.frame.maxY + 2)
        textField.frame.size = CGSize(width: self.view.frame.width - 64, height: self.view.frame.height/12)
        textField.center.x = self.view.center.x
        textField.placeholder = "Surname"
        return textField
    }()
    lazy var emailTextField: TextField = {
        let textField = TextField()
        textField.frame.origin = CGPoint(x: self.view.center.x , y: self.surnameTextField.frame.maxY + 2)
        textField.frame.size = CGSize(width: self.view.frame.width - 64, height: self.view.frame.height/12)
        textField.center.x = self.view.center.x
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        return textField
    }()
    lazy var passwordTextField: TextField = {
        let textField = TextField()
        textField.frame.origin = CGPoint(x: self.view.center.x , y: self.emailTextField.frame.maxY + 2)
        textField.frame.size = CGSize(width: self.view.frame.width - 64, height: self.view.frame.height/12)
        textField.center.x = self.view.center.x
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    lazy var birthTextField: TextField = {
        let textField = TextField()
        textField.frame.origin = CGPoint(x: self.view.center.x , y: self.passwordTextField.frame.maxY + 2)
        textField.frame.size = CGSize(width: self.view.frame.width - 64, height: self.view.frame.height/12)
        textField.center.x = self.view.center.x
        textField.placeholder = "Birthday"
        textField.keyboardType = .numbersAndPunctuation
        return textField
    }()
    lazy var submitButton: Button = {
        let btn = Button()
        btn.frame = CGRect(x: self.view.center.x, y: self.birthTextField.frame.maxY + 16, width: self.passwordTextField.frame.width, height: self.view.frame.height/15)
        btn.center.x = self.view.center.x
        btn.setTitle("Login", for: .normal)
        btn.addTarget(self, action: #selector(registrtaion), for: .touchUpInside)
        return btn
    }()
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = UIColor(displayP3Red: 212/255, green: 212/255, blue: 212/255, alpha: 1)
        view.addSubview(logoView)
        view.addSubview(nameTextField)
        view.addSubview(surnameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(birthTextField)
        view.addSubview(submitButton)
    }
    @objc func registrtaion(){
        let email = emailTextField.text!.lowercased()
        let finalEmail = email.trimmingCharacters(in: CharacterSet.whitespaces)
        let name = nameTextField.text!
        let surname = surnameTextField.text!
        let birth = birthTextField.text!
        let password = passwordTextField.text!
        
        if  password.isEmpty || finalEmail.isEmpty || (name.isEmpty) || (surname.isEmpty) || (birth.isEmpty){
            self.view.endEditing(true)
            self.showMessage("please check your text fields", type: .info)
        } else {
            self.showMessage("Загрузка...", type: .info)
            self.view.endEditing(true)
            authService.signUp(finalEmail, password: password, name: name, surname: surname, birth: birth, vc: self)
            
        }
    }

}
