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
        $0.setTitle("I am Sure of Joining This Group", for: .normal)
        $0.addTarget(self, action: #selector(joinNow), for: .touchUpInside)
        
        return $0
    }(UIButton())
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Color")
        view.addSubview(labelContent)
        view.addSubview(buttonJoin)
        
        NSLayoutConstraint.activate([
            //            labelContent.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            labelContent.leftAnchor.constraint(equalTo: view.leftAnchor),
            labelContent.heightAnchor.constraint(equalToConstant: 300),
            labelContent.widthAnchor.constraint(equalToConstant: 400),
            
            
            buttonJoin.topAnchor.constraint(equalTo: view.topAnchor, constant: 500),
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
        dismiss(animated: true)
    }
    
    func click(){
        var email  = Auth.auth().currentUser!.email!
                                self.db.collection("Groups").document("Yoga-0").updateData([
                                    "emailarray" : FieldValue.arrayUnion([email])
                                ])
            
}
}
