//
//  JoiningViewController.swift
//  sheet2
//
//  Created by AlDanah Aldohayan on 15/01/2022.
//

import UIKit
import Firebase
import Lottie

class JoiningViewController: UIViewController {
    
    let db = Firestore.firestore()
    var userID = Auth.auth().currentUser?.uid
    
    
    let labelContent : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        
        return $0
    }(UILabel())
    
    let buttonJoin : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(#colorLiteral(red: 0.5137255192, green: 0.5137255192, blue: 0.5137255192, alpha: 1))
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15.0
        $0.layer.borderWidth = 2.0
        $0.setTitle("انا متاكدة لدخول المجموعة", for: .normal)
        $0.addTarget(self, action: #selector(joinNow), for: .touchUpInside)
        
        return $0
    }(UIButton())
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Color")
        view.addSubview(labelContent)
        view.addSubview(buttonJoin)
        
        NSLayoutConstraint.activate([
                        labelContent.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            labelContent.leftAnchor.constraint(equalTo: view.leftAnchor, constant:  10),
            labelContent.heightAnchor.constraint(equalToConstant: 250),
            labelContent.widthAnchor.constraint(equalToConstant: 360),
            
            
                        buttonJoin.topAnchor.constraint(equalTo: labelContent.bottomAnchor, constant: 50),
            buttonJoin.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            buttonJoin.widthAnchor.constraint(equalToConstant: 300)
            
        ])
        bringContent()
        
    }
    func bringContent() {
        db.collection("Groups")
            .getDocuments {
                qurySnapShot, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    for doc in qurySnapShot!.documents {
                        let data = doc.data()
                        if (data["name"] as? String ?? "not found") == "Yoga" {
                            self.labelContent.text = data["content"] as? String ?? "not found"
                        }
                        
                    }
                }
            }
    }
    @objc func joinNow(){
        click()
        updateYoga()
        dismiss(animated: true)
    }
    
    func click(){
        var email  = Auth.auth().currentUser!.email!
        self.db.collection("Groups").document("Yoga-0").updateData([
            "emailarray" : FieldValue.arrayUnion([email])
        ])
        
    }
    func updateYoga(){
        if let userID = userID {
            self.db.collection("Groups").getDocuments { querySnapShot, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    for doc in querySnapShot!.documents {
                        let data = doc.data()
                        var name = data["name"] as! String
                        if name == "Yoga" {
                            self.db.collection("Users").document(userID).updateData([
                                "groups" : FieldValue.arrayUnion([name])
                            ])

                        }
                    }
                }
            }
        }
    }
}
