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
        //$0.textRect(forBounds: CGRect(x: 0, y: 0, width: 400, height: 400), limitedToNumberOfLines: 10)
        
        return $0
    }(UILabel())
    
    let buttonJoin : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.setTitle("I am Sure of Joining This Group", for: .normal)
        $0.addTarget(self, action: #selector(joinNow), for: .touchUpInside)
        
        return $0
    }(UIButton())
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(labelContent)
        view.addSubview(buttonJoin)
        
        NSLayoutConstraint.activate([
            //            labelContent.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            labelContent.leftAnchor.constraint(equalTo: view.leftAnchor),
            labelContent.heightAnchor.constraint(equalToConstant: 300),
            labelContent.widthAnchor.constraint(equalToConstant: 400),
            
            
            buttonJoin.topAnchor.constraint(equalTo: view.topAnchor, constant: 500),
            buttonJoin.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
            
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
                            self.labelContent.text = data["contentGroup"] as? String ?? "not found"
                        }
                        
                    }
                }
            }
    }
    @objc func joinNow(){
        click()
        dismiss(animated: true)
//        addUserToGroup()
    }
    
    func click(){
        var email  = Auth.auth().currentUser!.email!
//        db.collection("Groups")
//            .getDocuments {
//                    qurySnapShot, error in
//                    if let error = error {
//                        print(error.localizedDescription)
//                    } else {
//                        for doc in qurySnapShot!.documents {
//                            let data = doc.data()
                                self.db.collection("Groups").document("Yoga-0").updateData([
                                    "emailarray" : FieldValue.arrayUnion([email])
                                ])
                            
//        let washingtonRef = db.collection("Groups").document("Yoga-0")
//
//        // Atomically add a new region to the "regions" array field.
//        let arrUnion = washingtonRef.update({
//          regions: admin.firestore.FieldValue.arrayUnion('greater_virginia')
//        })
//                        }
//                    }
//            }
//    }
//    func addUserToGroup(){
//        var email = Auth.auth().currentUser!.email!
//        db.collection("Groups")
//            .getDocuments {
//                    qurySnapShot, error in
//                if let error = error {
//                    print(error.localizedDescription)
//                } else {
//                    for doc in qurySnapShot!.documents {
//                        let data = doc.data()
//                        self.db.collection("Users").document(email).updateData([
//                            "groups" : data["name"]
//                        ])
//                    }
////                    self.db.collection("Users").document(email).updateData(["groups" : qurySnapShot?"groups" : qurySnapShot?.get("name") ?? "nilll" ?? "nilll"])
//                }
//            }
//    }
}
}
