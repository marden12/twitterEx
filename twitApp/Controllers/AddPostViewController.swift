//
//  AddPostViewController.swift
//  twitApp
//
//  Created by Dayana Marden on 15.04.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
var databaseRef: DatabaseReference! {
    return Database.database().reference()
}
class AddPostViewController: UIViewController {
    var myArray: [Users] = []
    lazy var logoView: LogoView = {
        let v = LogoView()
        v.center = self.view.center
        v.frame = CGRect(x: 0, y: self.view.frame.minY + 64, width: 200, height: 100)
        v.center.x = self.view.center.x
        v.backgroundColor = .clear
        v.subname.text = "Add post"
        return v
    }()
    lazy var hashtagTextField: TextField = {
        let textField = TextField()
        textField.frame.origin = CGPoint(x: self.view.center.x , y: self.logoView.frame.maxY + 8)
        textField.frame.size = CGSize(width: self.view.frame.width - 64, height: self.view.frame.height/12)
        textField.center.x = self.view.center.x
        textField.placeholder = "Enter hashtag without #, please"
        return textField
    }()
    lazy var textPost: UITextView = {
        let tv = UITextView()
        tv.frame = CGRect(x: 0, y: self.hashtagTextField.frame.maxY + 16, width: self.hashtagTextField.frame.width, height: self.view.frame.height/3)
        tv.center.x = self.view.center.x
        tv.layer.borderWidth = 1
        tv.layer.cornerRadius = 10
        tv.layer.borderColor = UIColor(displayP3Red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
        tv.backgroundColor = .clear
        return tv
    }()
    lazy var subminButton: Button = {
        let btn = Button()
        btn.frame = CGRect(x: self.view.center.x, y: self.textPost.frame.maxY + 8, width: self.textPost.frame.width, height: self.view.frame.height/15)
        btn.center.x = self.view.center.x
        btn.setTitle("Add post", for: .normal)
        btn.addTarget(self, action: #selector(submitButton), for: .touchUpInside)
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
        view.addSubview(hashtagTextField)
        view.addSubview(textPost)
        view.addSubview(subminButton)
        view.addSubview(cancelButton)

    }
    @objc func submitButton(){
        if (self.hashtagTextField.text?.isEmpty)! || self.textPost.text.isEmpty{
            showMessage("Please,check your post", type: .error)
        }else{
            
            let userInfo = ["email": (Auth.auth().currentUser?.email)!,"hashtag": self.hashtagTextField.text!, "text": self.textPost.text, "date": getTodayString()] as [String : Any]
            let userRef = databaseRef.child("posts").childByAutoId()
            userRef.setValue(userInfo)
            self.dismiss(animated: true, completion: nil)
        }
    }
    @objc func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
        
    func getTodayString() -> String{
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        let today_string = String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
        return today_string
    }
}
