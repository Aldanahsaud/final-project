//
//  SignUpViewController.swift
//  sheet2
//
//  Created by AlDanah Aldohayan on 04/01/2022.
//

import UIKit
import Firebase
import Lottie

class SignUpViewController: UITabBarController {
    
    let db = Firestore.firestore()
    
    let imagePicker = UIImagePickerController()
    var imageName = "\(UUID().uuidString).png"
     
    
    let backButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("رجوع", for: .normal)
        $0.setTitleColor(.blue, for: .normal)
        $0.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        $0.backgroundColor = #colorLiteral(red: 0.7927808166, green: 0.9660930037, blue: 0.9733143449, alpha: 1)
        $0.layer.cornerRadius = 8
        $0.setTitleColor( #colorLiteral(red: 0.4041165113, green: 0.6092897654, blue: 0.60647434, alpha: 1), for: .normal)
        $0.sizeToFit()
        $0.layer.shadowColor = UIColor(named: "buttonShadow")?.cgColor
        $0.layer.shadowOpacity = 0.8
        $0.layer.shadowOffset = CGSize(width: 1, height: 1)
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor(named: "buttonBorder")?.cgColor
        
        return $0
    }(UIButton())
    
    var myImage : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "icons8-Doodle-MXJBhIDosJsE-50-ffffff")
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.masksToBounds = false
        $0.clipsToBounds = true
        $0.tintColor = .gray
        
        return $0
        
    }(UIImageView())
    
    let addPhoto : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("+", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        $0.setTitleColor(#colorLiteral(red: 0.1948547363, green: 0.1630736887, blue: 0.9492306113, alpha: 1) , for: .normal)
        $0.addTarget(self, action: #selector(addPhotoAction), for: .touchUpInside)

        return $0
    }(UIButton())
    var textFieldName : UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderWidth = 1.0
//        $0.layer.borderColor = UIColor(named: "Color")?.cgColor
        $0.backgroundColor =  .white
        $0.placeholder = "الاسم"
        $0.textAlignment = .right
        
        return $0
    }(UITextField())
    
    var textFieldUsername : UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.borderStyle = .roundedRect
        $0.placeholder = "اسم المستخدم"
        $0.textAlignment = .right
        
        
        return $0
    }(UITextField())
    var textFiledEmail : UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.borderStyle = .roundedRect
        $0.placeholder = "البريد الالكتروني"
        $0.textAlignment = .right
        
        
        
        return $0
    }(UITextField())
    var textFieldPassword : UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "كلمة المرور"
        $0.textAlignment = .right
        $0.borderStyle = .roundedRect
        $0.isSecureTextEntry = true
        

        return $0
    }(UITextField())
    let signUp : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("تسجيل الدخوب", for: .normal)
        $0.setTitleColor(.blue, for: .normal)
        $0.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        $0.backgroundColor = #colorLiteral(red: 0.7927808166, green: 0.9660930037, blue: 0.9733143449, alpha: 1)
        $0.layer.cornerRadius = 8
        $0.setTitleColor( #colorLiteral(red: 0.4041165113, green: 0.6092897654, blue: 0.60647434, alpha: 1), for: .normal)
        $0.sizeToFit()
        $0.layer.shadowColor = UIColor(named: "buttonShadow")?.cgColor
        $0.layer.shadowOpacity = 0.8
        $0.layer.shadowOffset = CGSize(width: 1, height: 1)
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor(named: "buttonBorder")?.cgColor
        $0.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)

        return $0
    }(UIButton())
//    var labelCreat : UILabel = {
//
//    }(UILabel())
    
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        view.backgroundColor = #colorLiteral(red: 0.4041165113, green: 0.6092897654, blue: 0.60647434, alpha: 1)
        let width = view.frame.width-100
        let height = view.frame.height-300
        var y = 0.0
        
         
        //Adding SubViews
        view.addSubview(backButton)
        view.addSubview(myImage)
        view.addSubview(addPhoto)
        view.addSubview(textFieldName)
        view.addSubview(textFiledEmail)
        view.addSubview(textFieldUsername)
        view.addSubview(textFieldPassword)
        view.addSubview(signUp)
        
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            backButton.widthAnchor.constraint(equalToConstant: 55),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            
            myImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 77),
            myImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            myImage.widthAnchor.constraint(equalToConstant: 80),
            myImage.heightAnchor.constraint(equalToConstant: 80),
            
            addPhoto.topAnchor.constraint(equalTo: myImage.bottomAnchor, constant: 5),
            addPhoto.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            
            textFieldName.topAnchor.constraint(equalTo: addPhoto.bottomAnchor, constant: 20),
            textFieldName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            textFieldName.widthAnchor.constraint(equalToConstant: 340),
            textFieldName.heightAnchor.constraint(equalToConstant: 50),
            
            textFiledEmail.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 18),
            textFiledEmail.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            textFiledEmail.widthAnchor.constraint(equalToConstant: 340),
            textFiledEmail.heightAnchor.constraint(equalToConstant: 50),
            
            textFieldUsername.topAnchor.constraint(equalTo: textFiledEmail.bottomAnchor, constant: 18),
            textFieldUsername.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            textFieldUsername.widthAnchor.constraint(equalToConstant: 340),
            textFieldUsername.heightAnchor.constraint(equalToConstant: 50),
            
            textFieldPassword.topAnchor.constraint(equalTo: textFieldUsername.bottomAnchor, constant: 18),
            textFieldPassword.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            textFieldPassword.widthAnchor.constraint(equalToConstant: 340),
            textFieldPassword.heightAnchor.constraint(equalToConstant: 50),
            
            signUp.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 20),
            signUp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUp.widthAnchor.constraint(equalToConstant: 150),
            signUp.heightAnchor.constraint(equalToConstant: 50),
        ])
         
         
         
         
//        Profile Image
        myImage.layer.cornerRadius = myImage.frame.height/2
         
         
        //Add photo Btn


        //Name

        //Username

        //Email


        //Password


        //Signup
        signUp.layer.cornerRadius = signUp.frame.height/2
         
    
    hideKeyboardWhenTappedAround()
        
        
//        func configureAnimation() {
//            let animation = Animation.named("profile")
//            let animationView = AnimationView(animation:animation)
//            animationView.contentMode = .scaleAspectFill
//            animationView.frame = CGRect(x: width/4, y: 60, width: width/2, height: width/2)
//            y+=animationView.frame.height
//            stackView.addSubview(animationView)
//            animationView.play()
//            animationView.loopMode = .loop
//            animationView.animationSpeed = 1
//          }
//        configureAnimation()
    }
    
    
    @objc func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
//    @objc func signInAction(){
//        let vc = LoginViewController()
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
//    }
    
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
        if myImage.image != UIImage(named: "icons8-Doodle-MXJBhIDosJsE-50-ffffff") {
            uploadImage()
        }

        self.db.collection("Users")
            .document(userId).setData(
                [
                    "email" : self.textFiledEmail.text!,
                    "name" : self.textFieldName.text!,
                    "username" : self.textFieldUsername.text!,
                    "userIcon": myImage.image == UIImage(named: "icons8-Doodle-MXJBhIDosJsE-50-ffffff") ? "nil" : imageName,
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
