//
//  PostViewController.swift
//  sheet2
//
//  Created by AlDanah Aldohayan on 03/01/2022.
//

import UIKit
import Firebase

class PostViewController: UIViewController {
    
    let db = Firestore.firestore()
    var userID = Auth.auth().currentUser?.uid
    var email = Auth.auth().currentUser?.email
    var arrpost:[Posts] = []
    var objectPost = ""
    
    let thePost : UITextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.text = "  شاركي مع الاحباب في ٢٠٠ حرف "
        $0.layer.cornerRadius = 15.0
        $0.layer.borderWidth = 2.0
        $0.textAlignment = .right
        $0.layer.borderColor = UIColor(#colorLiteral(red: 0.666983366, green: 0.8120718598, blue: 0.8098518252, alpha: 1)).cgColor
        
        return $0
    }(UITextView())
    
    let linkTextField : UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "  رابط المشاركة"
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15.0
        $0.layer.borderWidth = 2.0
        $0.textAlignment = .right
        $0.layer.borderColor = UIColor(#colorLiteral(red: 0.666983366, green: 0.8120718598, blue: 0.8098518252, alpha: 1)).cgColor
        
        return $0
    }(UITextField())
    
    let buttonPost : UIButton = {
        $0.setTitle("☑️", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = UIColor(#colorLiteral(red: 0.666983366, green: 0.8120718598, blue: 0.8098518252, alpha: 1))
        $0.addTarget(self, action: #selector(addPost), for: .touchUpInside)
        
        
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(thePost)
        view.addSubview(buttonPost)
        view.addSubview(linkTextField)
        view.backgroundColor = UIColor(named: "Color")
        
        NSLayoutConstraint.activate([
            
            thePost.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            thePost.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thePost.widthAnchor.constraint(equalToConstant: 380),
            thePost.heightAnchor.constraint(equalToConstant: 400),
            
            linkTextField.topAnchor.constraint(equalTo: thePost.bottomAnchor, constant: 20),
            linkTextField.widthAnchor.constraint(equalToConstant: 250),
            linkTextField.heightAnchor.constraint(equalToConstant: 50),
            linkTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttonPost.topAnchor.constraint(equalTo: linkTextField.bottomAnchor, constant: 30),
            buttonPost.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonPost.widthAnchor.constraint(equalToConstant: 100),
            buttonPost.heightAnchor.constraint(equalToConstant: 50)
        ])
        hideKeyboardWhenTappedAround()
    }
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @objc func addPost() {
        postsCollection()
        addNumOfPost()
            }
    func addNumOfPost(){
        
        if let userID = userID {
            db.collection("Users").document(userID).getDocument { querySnapShot, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    var x: Int = querySnapShot?.get("posts") as! Int
                    self.db.collection("Users").document(userID).updateData([
                        "posts": x + 1
                    ])
                    
                }
            }
        }
        
        
        
        
        
    }
    func postsCollection() {
        let cDate = Date()
        let email = Auth.auth().currentUser!.email!
        
        var conntent = self.thePost.text!
        var date = cDate
        var link = self.linkTextField.text!
        var usearName = ""
        
        
        if let userID = userID {
            db.collection("Users").document(userID)
                .getDocument {
                        qurySnapShot, error in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {

                            self.db.collection("Posts")
                                .document("\(email)-\(self.thePost.text!)")
                                    .setData( [
                                        "content" : conntent,
                                        "link" : link,
                                        "usernamep" : qurySnapShot?.get("username"),
                                        "date": date,
                                        "email" : email
                                        
                                    ])
                           

                            
                                {(error) in
                                    if error == nil {
                                        print("Added Succ..")
                                        self.thePost.text = ""
                                        self.linkTextField.text = ""

                                        
                                    }else {
                                        print(error!.localizedDescription)
                                        
                                    }
                                }
                            self.arrpost.append(Posts(content: conntent, username: usearName, link: link, date: date))
                        }
                    }
                
        } else {
            print("oops")
        }
        
        
        
    }
    
}
