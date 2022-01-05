//
//  SignUpViewController.swift
//  sheet2
//
//  Created by AlDanah Aldohayan on 04/01/2022.
//

import UIKit
import Firebase

class SignUpViewController: UITabBarController {
    
    let db = Firestore.firestore()
    
    let imagePicker = UIImagePickerController()
    var imageName = "\(UUID().uuidString).png"
     
    let stackView = UIStackView()
    var myImage = UIImageView()
    let addPhoto = UIButton()
    var textFieldName = UITextField()
    var textFieldUsername = UITextField()
    var textFiledEmail = UITextField()
    var textFieldPassword = UITextField()
    let signUp = UIButton()
    var labelCreat = UILabel()
    var signIn = UIButton()
    
    
    let backButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("رجوع", for: .normal)
        $0.setTitleColor(.blue, for: .normal)
        $0.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        $0.backgroundColor = #colorLiteral(red: 0.9243349433, green: 0.8509200811, blue: 0.727404654, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.setTitleColor(.white, for: .normal)
        $0.sizeToFit()
        return $0
    }(UIButton())
    
//    let backButton: UIButton = {
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.setTitle("رجوع للخلف", for: .normal)
//        $0.setTitleColor(.blue, for: .normal)
//        $0.addTarget(self, action: #selector(goBack), for: .touchUpInside)
//
//        return $0
//    }(UIButton())
//
//    let textFeildUsername: UITextField = {
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.placeholder = "اسم المستخدم"
//        $0.clipsToBounds = true
//        $0.layer.cornerRadius = 6
//        $0.layer.borderWidth = 0.25
//
//        return $0
//    }(UITextField())
//
//    let passwordTextFeild: UITextField = {
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.placeholder = "رمز المرور"
//        $0.clipsToBounds = true
//        $0.layer.cornerRadius = 6
//        $0.layer.borderWidth = 0.25
//
//        return $0
//    }(UITextField())
//
//    let nameTextFeild: UITextField = {
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.placeholder = "ادخل اسمك"
//        $0.clipsToBounds = true
//        $0.layer.cornerRadius = 6
//        $0.layer.borderWidth = 0.25
//
//        return $0
//    }(UITextField())
//
//    let signningUpButton: UIButton = {
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.backgroundColor = .brown
//        $0.setTitle("دخول", for: .normal)
//        $0.addTarget(self, action: #selector(signInAction), for: .touchDown)
//
//        return $0
//    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        view.backgroundColor = .white
        
        let width = view.frame.width-100
        let height = view.frame.height-300
        var y = 0.0
         
        //Adding SubViews
        view.addSubview(stackView)
        stackView.addSubview(myImage)
        stackView.addSubview(addPhoto)
        stackView.addSubview(textFieldName)
        stackView.addSubview(textFiledEmail)
        stackView.addSubview(textFieldUsername)
        stackView.addSubview(textFieldPassword)
        stackView.addSubview(signUp)
        view.addSubview(signIn)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            backButton.widthAnchor.constraint(equalToConstant: 55),
            backButton.heightAnchor.constraint(equalToConstant: 23),
            
//            signIn.widthAnchor.constraint(equalToConstant: width),
//            signIn.heightAnchor.constraint(equalToConstant: width/14),
//            signIn.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
         
         
        // stack view
       stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        stackView.center = view.center
         
         
        //Profile Image
        myImage.frame = CGRect(x: 0, y: y, width: width/2, height: width/2)
        myImage.image = UIImage(systemName: "person.circle")
        myImage.layer.cornerRadius = myImage.frame.height/2
        myImage.clipsToBounds = true
        myImage.tintColor = .gray
        y+=myImage.frame.height
         
         
        //Add photo Btn
        addPhoto.frame = CGRect(x: 100, y: 50, width: width, height: height/14)
        addPhoto.setTitle("إضافة صورة شخصية", for: .normal)
        addPhoto.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        addPhoto.setTitleColor(#colorLiteral(red: 0.1948547363, green: 0.1630736887, blue: 0.9492306113, alpha: 1) , for: .normal)
        addPhoto.addTarget(self, action: #selector(addPhotoAction), for: .touchUpInside)
        y+=addPhoto.frame.height
        y+=20
         
         
        //Name
        textFieldName.frame = CGRect(x: 0, y: y, width: width, height: height/14)
        textFieldName.borderStyle = .roundedRect
        textFieldName.placeholder = "الاسم"
        textFieldName.textAlignment = .right
        y+=textFieldName.frame.height
        y+=10
         
        //Username
        textFieldUsername.frame = CGRect(x: 0, y: y, width: width, height: height/14)
        textFieldUsername.borderStyle = .roundedRect
        textFieldUsername.placeholder = "اسم المستخدم"
        textFieldUsername.textAlignment = .right
        y+=textFieldUsername.frame.height
        y+=10
        
        
        //Email
        textFiledEmail.frame = CGRect(x: 0, y: y, width: width, height: height/14)
        textFiledEmail.borderStyle = .roundedRect
        textFiledEmail.placeholder = "البريد الالكتروني"
        textFiledEmail.textAlignment = .right
        y+=textFiledEmail.frame.height
        y+=10
         

        //Password
        textFieldPassword.frame = CGRect(x: 0, y: y, width: width, height: height/14)
        textFieldPassword.placeholder = "كلمة المرور"
        textFieldPassword.textAlignment = .right
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.isSecureTextEntry = true
        y+=textFieldPassword.frame.height
        y+=20


        //Signup
        signUp.frame = CGRect(x: 0, y: y, width: width, height: height/14)
        signUp.backgroundColor = #colorLiteral(red: 0.9243349433, green: 0.8509200811, blue: 0.727404654, alpha: 1)
        signUp.layer.cornerRadius = signUp.frame.height/2
        signUp.setTitleColor(.white, for: .normal)
        signUp.setTitle("التسجيل", for: .normal)
        signUp.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        y+=signUp.frame.height
        y+=100
         
          
        //Signin
//        signIn.frame = CGRect(x: 0, y: y, width: width, height: height/14)
//        signIn.translatesAutoresizingMaskIntoConstraints = false
//        signIn.setTitle("لديك حساب ؟ سجل دخولك هنا", for: .normal)
//        signIn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        signIn.setTitleColor(#colorLiteral(red: 0.1948547363, green: 0.1630736887, blue: 0.9492306113, alpha: 1), for: .normal)
//        signIn.contentHorizontalAlignment = .center
//        signIn.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
    
    
    hideKeyboardWhenTappedAround()
        
        
//        view.addSubview(emailTextFeild)
//        view.addSubview(passwordTextFeild)
//        view.addSubview(signningUpButton)
//        view.addSubview(backButton)
//
//        NSLayoutConstraint.activate([
//            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
//            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
//
//            emailTextFeild.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
//            emailTextFeild.widthAnchor.constraint(equalToConstant: 300),
//            emailTextFeild.heightAnchor.constraint(equalToConstant: 50),
//            emailTextFeild.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
//
//
//            passwordTextFeild.topAnchor.constraint(equalTo: emailTextFeild.bottomAnchor, constant: 20),
//            passwordTextFeild.widthAnchor.constraint(equalToConstant: 300),
//            passwordTextFeild.heightAnchor.constraint(equalToConstant: 50),
//            passwordTextFeild.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
//
//            signningUpButton.topAnchor.constraint(equalTo: passwordTextFeild.bottomAnchor, constant: 20),
//            signningUpButton.widthAnchor.constraint(equalToConstant: 70),
//            signningUpButton.heightAnchor.constraint(equalToConstant: 50),
//            signningUpButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 150)
//
//        ])
    }
    
    @objc func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func signInAction(){
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func signUpAction() {
        if textFiledEmail.text != "" && textFieldPassword.text != "" {
            Auth.auth().createUser(withEmail: textFiledEmail.text!, password: textFieldPassword.text!) { user, Error in
                
                if Error == nil {
                    self.addUser(userId: (user?.user.uid)!)
                    let nextVC = HomeViewController()
                    nextVC.modalPresentationStyle = .fullScreen
                    self.present(nextVC, animated: true, completion: nil)
                    
                } else{
                    let alert = UIAlertController(title: "تنبيه", message: Error?.localizedDescription, preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            let alert = UIAlertController(title: "بيانات ناقصة", message: "الرجاء التأكد من إدخال البريد الإلكتروني و كلمة المرور", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
        }
        dismiss(animated: true, completion: nil)
    }
    @objc func addPhotoAction() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func addUser(userId: String) {
        if myImage.image != UIImage(systemName: "person.circle") {
            uploadImage()
        }
        
        self.db.collection("Users")
            .document(userId).setData(
                [
                    "email" : self.textFiledEmail.text!,
                    "name" : self.textFieldName.text!,
                    "username" : "",
                    "userIcon": myImage.image == UIImage(systemName: "person.circle") ? "nil" : imageName,
                    "posts" : 0,
                    "password" : self.textFieldPassword.text!,
                    "groups" : "",
                    "following" : ""
                ])
        {(error) in
            if error == nil {
                print("Added Succ..")
                
            }else {
                print(error!.localizedDescription)
                
            }
        }
        
    }
    
    func uploadImage() {
        
        let imagefolder = Storage.storage().reference().child("images")
        if let imageData = myImage.image?.jpegData(compressionQuality: 0.1) {
            imagefolder.child(imageName).putData(imageData, metadata: nil){
                (metaData , err) in
                if let error = err {
                    print(error.localizedDescription)
                }else {
                    print("تم رفع الصورة بنجاح")
                }
            }
        }
        
    }
    
    @objc func dismissKeyboard() {
          view.endEditing(true)
         }
    
    func hideKeyboardWhenTappedAround() {
       
      let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
      tap.cancelsTouchesInView = false
      view.addGestureRecognizer(tap)
     }
}


extension SignUpViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        myImage.image = pickedImage
        picker.dismiss(animated: true, completion: nil)
    }
}
