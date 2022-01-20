//
//  SettingViewController.swift
//  sheet2
//
//  Created by AlDanah Aldohayan on 20/01/2022.
//

import UIKit
import Firebase

class SettingViewController: UIViewController {
    
    var defaults = UserDefaults.standard
    let userId = Auth.auth().currentUser?.uid
    let db = Firestore.firestore()
    
    let darkModeButton : UIButton = {
        $0.addTarget(self, action: #selector(darkAction), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "sun.max.fill"), for: .normal)
        $0.tintColor = .blue
        
        return $0
        
    }(UIButton())
    let textfieldName : UITextField = {
        $0.placeholder = "  غير اسمك  "
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15.0
        $0.layer.borderWidth = 2.0
        $0.textAlignment = .right
        $0.layer.borderColor = UIColor(#colorLiteral(red: 0.666983366, green: 0.8120718598, blue: 0.8098518252, alpha: 1)).cgColor
        
        return $0
    }(UITextField())
    
    let textfieldUsername : UITextField = {
        $0.placeholder = "  غير اسم المستخدم    "
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15.0
        $0.layer.borderWidth = 2.0
        $0.textAlignment = .right
        $0.layer.borderColor = UIColor(#colorLiteral(red: 0.666983366, green: 0.8120718598, blue: 0.8098518252, alpha: 1)).cgColor
        
        return $0
    }(UITextField())
    
    let textfieldEmail : UITextField = {
        $0.placeholder = "  غير البريد الالكتروني    "
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15.0
        $0.layer.borderWidth = 2.0
        $0.textAlignment = .right
        $0.layer.borderColor = UIColor(#colorLiteral(red: 0.666983366, green: 0.8120718598, blue: 0.8098518252, alpha: 1)).cgColor
        
        return $0
    }(UITextField())
    
    
    let buttonName : UIButton = {
        $0.setTitle("☑️", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = UIColor(#colorLiteral(red: 0.666983366, green: 0.8120718598, blue: 0.8098518252, alpha: 1))
        $0.addTarget(self, action: #selector(changeName), for: .touchUpInside)
        
        return $0
        
    }(UIButton())
    let buttonUsername : UIButton = {
        $0.setTitle("☑️", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = UIColor(#colorLiteral(red: 0.666983366, green: 0.8120718598, blue: 0.8098518252, alpha: 1))
        $0.addTarget(self, action: #selector(changeUsername), for: .touchUpInside)
        
        return $0
        
    }(UIButton())
    let buttonEmail : UIButton = {
        $0.setTitle("☑️", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = UIColor(#colorLiteral(red: 0.666983366, green: 0.8120718598, blue: 0.8098518252, alpha: 1))
        $0.addTarget(self, action: #selector(changeEmail), for: .touchUpInside)
        
        return $0
        
    }(UIButton())
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(darkModeButton)
        view.addSubview(textfieldName)
        view.addSubview(textfieldEmail)
        view.addSubview(textfieldUsername)
        view.addSubview(buttonName)
        view.addSubview(buttonEmail)
        view.addSubview(buttonUsername)
        
        
        view.backgroundColor = UIColor(named: "Color")
        
        NSLayoutConstraint.activate([
            darkModeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            darkModeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -5),
            darkModeButton.widthAnchor.constraint(equalToConstant: 150),
            darkModeButton.heightAnchor.constraint(equalToConstant: 90),
            
            
            textfieldName.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            textfieldName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            textfieldName.heightAnchor.constraint(equalToConstant: 50),
            textfieldName.widthAnchor.constraint(equalToConstant: 200),
            
            buttonName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100),
            buttonName.widthAnchor.constraint(equalToConstant: 100),
            buttonName.heightAnchor.constraint(equalToConstant: 100),
            buttonName.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),

            textfieldUsername.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            textfieldUsername.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            textfieldUsername.heightAnchor.constraint(equalToConstant: 50),
            textfieldUsername.widthAnchor.constraint(equalToConstant: 200),

            buttonUsername.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100),
            buttonUsername.widthAnchor.constraint(equalToConstant: 100),
            buttonUsername.heightAnchor.constraint(equalToConstant: 100),
            buttonUsername.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),

            textfieldEmail.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            textfieldEmail.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            textfieldEmail.heightAnchor.constraint(equalToConstant: 50),
            textfieldEmail.widthAnchor.constraint(equalToConstant: 200),

            buttonEmail.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100),
            buttonEmail.widthAnchor.constraint(equalToConstant: 100),
            buttonEmail.heightAnchor.constraint(equalToConstant: 100),
            buttonEmail.topAnchor.constraint(equalTo: view.topAnchor, constant: 280),

            
        ])

    }
    @objc func darkAction(){
        if defaults.bool(forKey: "mode") == false {
            
            if darkModeButton.imageView?.image == UIImage(systemName: "sun.max.fill") {
                UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .dark }
                darkModeButton.setImage(UIImage(systemName: "moon.fill"), for: .normal)
            }else if darkModeButton.imageView?.image == UIImage(systemName: "moon.fill"){
                if #available(iOS 10.0, *) {
                    UIApplication.shared.windows.forEach { window in
                        window.overrideUserInterfaceStyle = .light }
                    darkModeButton.setImage(UIImage(systemName: "sun.max.fill"), for: .normal)
                }
            }
        }else{
            print("haha fail")
        }
    }
    @objc func changeName(){
        let userId = Auth.auth().currentUser?.uid
        if let userId = userId {
            self.db.collection("Users").document(userId).updateData([
                "name" : self.textfieldName.text!,
                
            ])
        }
        self.textfieldName.text = ""
    }
    @objc func changeUsername(){
        let userId = Auth.auth().currentUser?.uid
        if let userId = userId {
            self.db.collection("Users").document(userId).updateData([
                "username" : self.textfieldUsername.text!,
                
            ])
        }
        self.textfieldUsername.text = ""
    }
    @objc func changeEmail(){
        let userId = Auth.auth().currentUser?.uid
        if let userId = userId {
            self.db.collection("Users").document(userId).updateData([
                "email" : self.textfieldEmail.text!
                
            ])
        }
        
        self.textfieldEmail.text = ""
        
    }
    

}


