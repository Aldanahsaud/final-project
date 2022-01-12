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
    var currentUser = Auth.auth().currentUser
    
    let thePost : UITextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .red
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 15.0
        return $0
    }(UITextView())
    
    let linkTextField : UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "paste the link"
        
        return $0
    }(UITextField())
    
    let buttonPost : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.setTitle("نشر", for: .normal)
        $0.addTarget(self, action: #selector(addPost), for: .touchUpInside)
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(thePost)
        view.addSubview(buttonPost)
        view.addSubview(linkTextField)
        
        NSLayoutConstraint.activate([
            
            thePost.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            thePost.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thePost.widthAnchor.constraint(equalToConstant: 400),
            thePost.heightAnchor.constraint(equalToConstant: 400),
            
            linkTextField.topAnchor.constraint(equalTo: thePost.bottomAnchor, constant: 20),
            linkTextField.widthAnchor.constraint(equalToConstant: 250),
            linkTextField.heightAnchor.constraint(equalToConstant: 50),
            linkTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            buttonPost.topAnchor.constraint(equalTo: linkTextField.bottomAnchor, constant: 15),
            buttonPost.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            buttonPost.widthAnchor.constraint(equalToConstant: 70),
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
            }
    
    func postsCollection() {
        let cDate = Date()
        if let userID = userID {
            db.collection("Users").document(userID)
                .getDocument {
                        qurySnapShot, error in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
//                                let data = qurySnapShot?.get("username")

                                self.db.collection("Posts")
                                    .addDocument(data: [
                                        "content" : self.thePost.text,
                                        "link" : self.linkTextField.text,
                                        "usernamep" : qurySnapShot?.get("username"),
                                        "date": cDate
                                        
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
                            
                        }
                    }
                
        } else {
            print("oops")
        }
        
        
        
    }
    
}
