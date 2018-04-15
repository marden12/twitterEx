//
//  EditProfileViewController.swift
//  twitApp
//
//  Created by Dayana Marden on 16.04.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
class EditProfileViewController: UIViewController {
    var databaseRef: DatabaseReference! {
        return Database.database().reference()
    }
    var myArray: [Users] = []
    lazy var logoView: LogoView = {
        let v = LogoView()
        v.frame = CGRect(x: 0, y: 64, width: 200, height: 100)
        v.center.x = self.view.center.x
        v.backgroundColor = .clear
        v.subname.text = "Edit Information"
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
    lazy var birthTextField: TextField = {
        let textField = TextField()
        textField.frame.origin = CGPoint(x: self.view.center.x , y: self.surnameTextField.frame.maxY + 2)
        textField.frame.size = CGSize(width: self.view.frame.width - 64, height: self.view.frame.height/12)
        textField.center.x = self.view.center.x
        textField.placeholder = "Birthday"
        return textField
    }()
    lazy var submitButton: Button = {
        let btn = Button()
        btn.frame = CGRect(x: self.view.center.x, y: self.birthTextField.frame.maxY + 16, width: self.birthTextField.frame.width, height: self.view.frame.height/15)
        btn.center.x = self.view.center.x
        btn.setTitle("Login", for: .normal)
        btn.addTarget(self, action: #selector(sumbit), for: .touchUpInside)
        return btn
    }()
    lazy var cancelButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "undo"), for: .normal)
        btn.frame = CGRect(x: self.view.frame.maxX - 64, y:self.view.frame.minX + 64, width: 24, height: 24)
        btn.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(displayP3Red: 212/255, green: 212/255, blue: 212/255, alpha: 1)
        view.addSubview(logoView)
        view.addSubview(nameTextField)
        view.addSubview(surnameTextField)
        view.addSubview(birthTextField)
        view.addSubview(submitButton)
        view.addSubview(cancelButton)
        for i in myArray{
            nameTextField.text = i.name
            surnameTextField.text = i.surname
            birthTextField.text = i.birth
        }
    }
    @objc func cancel(){
        self.dismiss(animated: true, completion: nil)
    }

    @objc func sumbit(){
    
        let userRef = databaseRef.child("users").child((Auth.auth().currentUser?.uid)!)
        
        userRef.updateChildValues(["name":nameTextField.text!,"surname": surnameTextField.text! ,"birth": birthTextField.text!,"email": (Auth.auth().currentUser?.email)!])
    
        self.dismiss(animated: true, completion: nil)
    }



}
