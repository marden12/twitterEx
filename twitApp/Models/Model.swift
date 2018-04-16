//
//  Model.swift
//  twitApp
//
//  Created by Dayana Marden on 15.04.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct Users {
    
    var name: String!
    var email: String?
    var surname: String?
    var birth: String!
    var ref: DatabaseReference?
    var key: String?
    
    init(snapshot: DataSnapshot){
        let value = snapshot.value as? NSDictionary
        key = snapshot.key
        ref = snapshot.ref
        name = value?["name"] as? String ?? ""
        email = value?["email"] as? String ?? ""
        surname = value?["surname"] as? String ?? ""
        birth = value?["birth"] as? String ?? ""
    }
    
    
    init(name: String, surname: String, birth: String,email: String){
        self.name = name
        self.surname = surname
        self.birth = birth
        self.email = email
        
    }
    func toAnyObject() -> Any {
        return [
            "email": email,
            "name": name,
            "surname": surname,
            "birth": birth
            
        ]
    }
    
}
struct Posts {
    var email: String?
    var text: String?
    var date: String!
    var hachtag: String?
    var ref: DatabaseReference?
    var key: String?
    var autoId: String?
    
    init(snapshot: DataSnapshot){
        let value = snapshot.value as? NSDictionary
        key = snapshot.key
        ref = snapshot.ref
        email = value?["email"] as? String ?? ""
        text = value?["text"] as? String ?? ""
        date = value?["date"] as? String ?? ""
        autoId = value?["autoId"] as? String ?? ""
        
        
    }
    init(email: String, text: String, date: String,hachtag: String,autoId: String){
        self.email = email
        self.text = text
        self.date = date
        self.hachtag = hachtag
        self.autoId = autoId
    }
    func toAnyObject() -> Any {
        return [
            "email": email,
            "text": text,
            "date": date,
            "hachtag": hachtag,
            "autoId": autoId
        ]
    }
    
}
