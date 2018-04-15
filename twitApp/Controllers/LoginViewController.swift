//
//  ViewController.swift
//  twitApp
//
//  Created by Dayana Marden on 11.04.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let authService = AuthenticationService()
    lazy var logoView: LogoView = {
        let v = LogoView()
        v.center = self.view.center
        v.frame = CGRect(x: 0, y: 16, width: 200, height: 100)
        v.center.x = self.view.center.x
        v.backgroundColor = .clear
        v.subname.text = "So, Let's strat?"
        return v
    }()
    lazy var emailTextField: TextField = {
        let textField = TextField()
        textField.frame.origin = CGPoint(x: self.view.center.x , y: self.logoView.frame.maxY)
        textField.frame.size = CGSize(width: self.view.frame.width - 64, height: self.view.frame.height/12)
        textField.center.x = self.view.center.x
        textField.placeholder = "Email"
        return textField
    }()
    lazy var passwordTextField: TextField = {
        let textField = TextField()
        textField.frame.origin = CGPoint(x: self.view.center.x , y: self.emailTextField.frame.maxY + 2)
        textField.frame.size = CGSize(width: self.view.frame.width - 64, height: self.view.frame.height/12)
        textField.center.x = self.view.center.x
        textField.placeholder = "Password"
        return textField
    }()
    lazy var submitButton: Button = {
        let btn = Button()
        btn.frame = CGRect(x: self.view.center.x, y: self.passwordTextField.frame.maxY + 16, width: self.passwordTextField.frame.width, height: self.view.frame.height/15)
        btn.center.x = self.view.center.x
        btn.setTitle("Login", for: .normal)
        btn.addTarget(self, action: #selector(login), for: .touchUpInside)
        return btn
    }()
    lazy var registrationButton: Button = {
        let btn = Button()
        btn.frame = CGRect(x: self.view.center.x, y: self.submitButton.frame.maxY + 16, width: self.submitButton.frame.width, height: self.view.frame.height/15)
        btn.center.x = self.view.center.x
        btn.setTitle("Registration", for: .normal)
        btn.backgroundColor = .white
        btn.setTitleColor(UIColor(displayP3Red: 94/255, green: 87/255, blue: 171/255, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(goToTegistration), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logoView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(submitButton)
        view.addSubview(registrationButton)
        view.backgroundColor = UIColor(displayP3Red: 212/255, green: 212/255, blue: 212/255, alpha: 1)
       
        
    }
    @objc func login(){
        let email = emailTextField.text!.lowercased()
        let finalEmail = email.trimmingCharacters(in: CharacterSet.whitespaces)
        let password = passwordTextField.text!
        
        if  password.isEmpty || finalEmail.isEmpty{
            self.view.endEditing(true)
            self.showMessage("please check your text fields", type: .info)
        } else {
            self.showMessage("loading...", type: .info)
            self.view.endEditing(true)
            authService.signIn(finalEmail, password: password, vs: self)
            
        }
    }
    @objc func goToTegistration(){
        let nv = RegistrationViewController()
        navigationController?.pushViewController(nv, animated: true)
    }



}

