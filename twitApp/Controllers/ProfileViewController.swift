//
//  ProfileViewController.swift
//  twitApp
//
//  Created by Dayana Marden on 14.04.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class ProfileViewController: UIViewController {
    var databaseRef: DatabaseReference! {
        return Database.database().reference()
    }
    let authService = AuthenticationService()
    var arr = Users(name: "", surname: "", birth: "", email: "")
    var needArr: [Users] = []
    
    var arr2 = Posts(email: "", text: "", date: "", hachtag: "")
    var needArr2: [Posts] = []
//var для USER INFO
    var name = ""
    var surname = ""
    var birth = ""
    var email = ""
//var для POSTS
    var emaill = ""
    var text = ""
    var date = ""
    var hachtag = ""
    
    let screen = UIScreen.main.bounds
//создаю UI

    lazy var logoView: LogoView = {
        let v = LogoView()
        v.frame = CGRect(x: 0, y: 16, width: 200, height: 100)
        v.center.x = self.view.center.x
        v.backgroundColor = .clear
        v.subname.text = "Profile"
        return v
    }()
    lazy var nameTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(displayP3Red: 94/255, green: 87/255, blue: 171/255, alpha: 1)
        label.font = UIFont(name: "Helvetica", size: 14)
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: self.logoView.frame.maxY, width: 200, height: 14)
        label.center.x =  self.view.center.x
        return label
    }()
    lazy var dateOfBirth: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(displayP3Red: 94/255, green: 87/255, blue: 171/255, alpha: 1)
        label.font = UIFont(name: "Helvetica", size: 14)
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: self.nameTitle.frame.maxY + 4, width: 200, height: 14)
        label.center.x =  self.view.center.x
        return label
    }()
    lazy var addButton: Button = {
        let btn = Button()
        btn.frame = CGRect(x: self.view.center.x, y: self.dateOfBirth.frame.maxY + 8, width: self.view.frame.width - 64, height: self.view.frame.height/15)
        btn.center.x = self.view.center.x
        btn.setTitle("Add new post", for: .normal)
        btn.addTarget(self, action: #selector(addPost), for: .touchUpInside)
        return btn
    }()
    lazy var editButton: Button = {
        let btn = Button()
        btn.frame = CGRect(x: self.view.center.x, y: self.addButton.frame.maxY + 8, width: self.addButton.frame.width, height: self.view.frame.height/15)
        btn.center.x = self.view.center.x
        btn.backgroundColor = .white
        btn.setTitleColor(UIColor(displayP3Red: 94/255, green: 87/255, blue: 171/255, alpha: 1), for: .normal)
        btn.setTitle("Edit profile", for: .normal)
        btn.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
        return btn
    }()
    lazy var searchButton: Button = {
        let btn = Button()
        btn.frame = CGRect(x: self.view.center.x, y: self.editButton.frame.maxY + 8, width: self.editButton.frame.width, height: self.view.frame.height/15)
        btn.center.x = self.view.center.x
        btn.setTitle("Search post ny hashtag", for: .normal)
        return btn
    }()
    fileprivate lazy var  containerView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        return view
    }()
    lazy var postsTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = self.containerView
        tableView.rowHeight = 90
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        tableView.center.x = self.view.center.x
        tableView.register(PostsTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isScrollEnabled = true
        return tableView
    }()
    override func viewDidLoad() {
        view.backgroundColor = UIColor(displayP3Red: 212/255, green: 212/255, blue: 212/255, alpha: 1)
        view.isUserInteractionEnabled = true
        view.addSubview(postsTable)
        self.containerView.frame = CGRect(x:UIScreen.main.bounds.minX , y: UIScreen.main.bounds.minY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
        [logoView,nameTitle,dateOfBirth,editButton,searchButton,addButton].forEach{
            self.containerView.addSubview($0)
        }
        let button = UIBarButtonItem(image: UIImage(named: "exit"), style: .plain, target: self, action: #selector(exit))
        self.navigationItem.rightBarButtonItem  = button
        fetchInformation()
        fetchPosts()
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.postsTable.reloadData()
        }

    }
//беру личную информацию из базы

    func fetchInformation(){
        databaseRef.child("users/").observe(.value, with: {(snapshot) in
            if let children = snapshot.children.allObjects as? [DataSnapshot] {
                for child in children {
                    if let childElement = child.value as? [String: Any] {
                        self.name = childElement["name"]! as! String
                        self.surname = childElement["surname"]! as! String
                        self.email = childElement["email"]! as! String
                        self.birth = childElement["birth"]! as! String
                        self.arr = Users(name: self.name, surname: self.surname, birth: self.birth, email: self.email)
                    }
                self.needArr.append(self.arr)
                }
                for i in self.needArr{
                    self.nameTitle.text = ("\(i.name!)" + " " + "\(i.surname!)")
                    self.dateOfBirth.text = i.birth!
                }
            }
            else {
                print("parse failure ")
            }
            DispatchQueue.main.async {
                self.postsTable.reloadData()
            }
        })
    }
//беру все посты из базы
    func fetchPosts(){
        databaseRef.child("posts/").observe(.value, with: {(snapshot) in
            if let children = snapshot.children.allObjects as? [DataSnapshot] {
                self.needArr2.removeAll()
                for child in children {
                    if let childElement = child.value as? [String: Any] {
                        self.emaill = childElement["email"]! as! String
                        self.hachtag = childElement["hashtag"]! as! String
                        self.date = childElement["date"]! as! String
                        self.text = childElement["text"]! as! String
                        self.arr2 = Posts(email: self.emaill, text: self.text, date: self.date, hachtag: self.hachtag)
                    }
                    self.needArr2.append(self.arr2)
                }
            }
            else {
                print("parse failure ")
            }
            DispatchQueue.main.async {
                self.postsTable.reloadData()
            }
        })
    }

//Добавляю
    @objc func addPost(){
        let nv = AddPostViewController()
        nv.myArray = needArr
        self.present(nv, animated: true, completion: nil)

    }
//Exit
    @objc func exit(){
    authService.logout()
        
    }
//Изменить профиль
    @objc func editProfile(){
        let nv = EditProfileViewController()
        nv.myArray = needArr
        self.present(nv, animated: true, completion: nil)
        
    }
}
extension ProfileViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return needArr2.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostsTableViewCell
        cell.comment_text.text = self.needArr2[indexPath.row].text
        cell.current_time.text = self.needArr2[indexPath.row].date
        cell.user_name.text = "@" + "\(self.needArr2[indexPath.row].email!)"
        return cell
    }
}
