//
//  LoginViewController.swift
//  sheet2
//
//  Created by AlDanah Aldohayan on 03/01/2022.
//

import UIKit
import Firebase

class LoginViewController: UITabBarController {
    
    @objc func goBack() {
        dismiss(animated: true, completion: nil)
    }
    let db = Firestore.firestore()
    var userId = Auth.auth().currentUser?.uid
    
    var stackView = UIStackView()
    let imageView = UIImageView()
    var textFieldEmail = UITextField()
    var textFieldPassword = UITextField()
    var forgetPassword = UIButton()
    var signIn = UIButton()
    var signUp = UIButton()
    
    let backButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("رجوع للخلف", for: .normal)
        $0.setTitleColor(.blue, for: .normal)
        $0.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15)
        ])
        
        hideKeyboardWhenTappedAround()
        setDesign()
    }
    
    func setDesign() {
        
        //Constants
        let width = view.frame.width-100
        let height = view.frame.height-300
        var y = 0.0
        
        //Adding SubViews
        view.addSubview(stackView)
        stackView.addSubview(imageView)
        stackView.addSubview(textFieldEmail)
        stackView.addSubview(textFieldPassword)
        stackView.addSubview(forgetPassword)
        stackView.addSubview(signIn)
        
        //stack view 1
        stackView.axis = .vertical
        stackView.frame = CGRect(x: 0, y: y, width: width, height: height)
        stackView.center = view.center
        
        //ImageView
        imageView.frame = CGRect(x: width*0.19, y: y, width: width/1.5, height: width/1.5)
        imageView.image = UIImage(named: "Image")
        y+=imageView.frame.height
        y+=20
        
        //Email
        textFieldEmail.frame = CGRect(x: 0, y: y, width: width, height: height/14)
        textFieldEmail.placeholder = "البريد الالكتروني"
        textFieldEmail.textAlignment = .right
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.textColor = .darkGray
        y+=textFieldEmail.frame.height
        y+=10
        
        //Password
        textFieldPassword.frame = CGRect(x: 0, y: y, width: width, height: height/14)
        textFieldPassword.placeholder = "كلمة المرور"
        textFieldPassword.textAlignment = .right
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.textColor = .darkGray
        textFieldPassword.isSecureTextEntry = true
        y+=textFieldPassword.frame.height
        
        //Forget
        forgetPassword.frame = CGRect(x:0, y: y, width: width, height: height/10)
        forgetPassword.setTitle("نسيت كلمة المرور؟", for: .normal)
        forgetPassword.titleLabel?.font = .systemFont(ofSize: 14)
        forgetPassword.contentHorizontalAlignment = .left
        forgetPassword.setTitleColor(#colorLiteral(red: 0.04236891121, green: 0.6102550626, blue: 0.2603748143, alpha: 1), for: .normal)
        forgetPassword.addTarget(self, action: #selector(forgetPasswordAction), for: .touchUpInside)
        y+=forgetPassword.frame.height
        y+=60
        
        // Signin
        signIn.frame = CGRect(x: 0, y: y, width: width, height: height/14)
        signIn.setTitle("تسجيل الدخول", for: .normal)
        signIn.setTitleColor(.white, for: .normal)
        signIn.layer.cornerRadius = signIn.frame.height/2
        signIn.backgroundColor = #colorLiteral(red: 0.04236891121, green: 0.6102550626, blue: 0.2603748143, alpha: 1)
        signIn.layer.masksToBounds = true
        signIn.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
        y+=signIn.frame.height
        y+=120
        
    }
    
    @objc func signInAction(){
        if textFieldEmail.text != "" && textFieldPassword.text != "" {
            Auth.auth().signIn(withEmail: textFieldEmail.text!, password: textFieldPassword.text! , completion: { user, error in
                
                if error == nil {
                    print("success")
                    self.dismiss(animated: false) {
                        self.dismiss(animated: false, completion: nil)
                    }
                    
                    
                }else{
                    let alert = UIAlertController(title: "تنبيه", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        } else {
            let alert = UIAlertController(title: "بيانات ناقصة", message: "الرجاء التأكد من إدخال البريد الإلكتروني و كلمة المرور", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    @objc func forgetPasswordAction() {
        let vc = ForgetPasswordViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
