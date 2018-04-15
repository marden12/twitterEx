//
//  AuthService.swift
//  twitApp
//
//  Created by Dayana Marden on 15.04.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import GSMessages

struct AuthenticationService {
    
    var databaseRef: DatabaseReference! {
        return Database.database().reference()
    }
    
    var storageRef: StorageReference! {
        
        return Storage.storage().reference()
    }
    
    
    // 4 - We sign in the User
    func signIn(_ email: String, password: String, vs: UIViewController){
        if email == "" || password == "" {
            
            vs.showMessage("Check your email or password,please", type: .success)
            
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    
                    print("You have successfully logged in")
                    (UIApplication.shared.delegate as? AppDelegate)?.loadMainPages()
                    
                } else {
                    vs.showMessage("Check your email or password,please", type: .success)
                    
                }
            }
        }
        
    }
    
    // 1 - We create firstly a New User
    func signUp(_ email: String, password: String,name: String,surname: String, birth:String, vc: UIViewController){
        if email == "" || password == "" || name == "" || surname == "", birth == "" {
            
            vc.showMessage("Check your name,email or password,please", type: .success)
            
        } else {
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    self.saveInfo(user, name: name, surname: surname, birth: birth)
                    self.signIn(email, password: password, vs: vc)
                    (UIApplication.shared.delegate as? AppDelegate)?.loadMainPages()
                    
                    
                }else {
                    vc.showMessage("Error in Firebase", type: .success)
                }
            })
        }
        
    }
    
    func resetPassword(_ email: String){
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            if error == nil {
                DispatchQueue.main.async(execute: {
                    print("error")
                })
            }else {
                print("error")
            }
        })
        
    }
    
    // 2 - We set the User Info
    func saveInfo(_ user: User!,name: String,surname: String,birth: String){
        let userInfo = ["name":name,"surname": surname ,"birth": birth,"email": user.email ]
        
        let userRef = databaseRef.child("users").child(user.uid)
        
        userRef.setValue(userInfo)
        
    }
    
    func logout(){
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                print("LOGOUT SUCCESS")
                (UIApplication.shared.delegate as? AppDelegate)?.loadLoginPages()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
    }
    
    
}

