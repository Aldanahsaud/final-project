//
//  ProfileViewController.swift
//  sheet2
//
//  Created by AlDanah Aldohayan on 03/01/2022.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var viewStoryboard: UIView!
    // Not Logged in View
    var userID = Auth.auth().currentUser?.uid
    
    let labelProfile: UILabel = {
        $0.text = "الصفحة الشخصية"
        $0.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        
        return $0
    }(UILabel())
    
    let loginButton: UIButton = {
        $0.backgroundColor = #colorLiteral(red: 0.9243349433, green: 0.8509200811, blue: 0.727404654, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("تسجيل دخول", for: .normal)
        $0.addTarget(self, action: #selector(profilrGoLogin), for: .touchUpInside)
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.black.cgColor
        $0.setTitleColor(.black, for: .normal)
        
        return $0
    }(UIButton())
    
    let SignUpButton: UIButton = {
        $0.backgroundColor = #colorLiteral(red: 0.9243349433, green: 0.8509200811, blue: 0.727404654, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("إنشاء حساب", for: .normal)
        $0.addTarget(self, action: #selector(profilrGoSignUp), for: .touchUpInside)
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.black.cgColor
        $0.setTitleColor(.black, for: .normal)
        
        return $0
    }(UIButton())
    
    
    
    // ++Logged in View vars and lets
    let db = Firestore.firestore()
    var userId = Auth.auth().currentUser?.uid
    let imagePicker = UIImagePickerController()
    var updateImageName = "\(UUID().uuidString).png"
    
    
    var postArray : [Posts] = []
    
    //UIImageView
    let userIcon : UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = #colorLiteral(red: 0.04236891121, green: 0.6102550626, blue: 0.2603748143, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.frame.size = CGSize(width: 70, height: 70)
        imageView.layer.cornerRadius = imageView.frame.width/2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //UIButton-signOutBtn
    let signOutBtn : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "signout"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = #colorLiteral(red: 0.04236891121, green: 0.6102550626, blue: 0.2603748143, alpha: 1)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(signOut), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // UILabel-nameLable
    let nameLbl : UILabel = {
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        $0.adjustsFontSizeToFitWidth = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "HelveticaNeue-Bold", size: 33)
        // HelveticaNeue
        return $0
    }(UILabel())
    //UILabel-numberOfGherasLbl
    let pointLbl : UILabel = {
        let numberOfGherasLbl = UILabel()
        numberOfGherasLbl.textAlignment = .center
        numberOfGherasLbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        numberOfGherasLbl.adjustsFontSizeToFitWidth = true
        numberOfGherasLbl.translatesAutoresizingMaskIntoConstraints = false
        return numberOfGherasLbl
    }()
    
    //UIButton-editPhotoBtn
    let editPhotoBtn : UIButton = {
        let editPhotoBtn = UIButton()
//        editPhotoBtn.setTitle("تعديل الصورة", for: .normal)
        editPhotoBtn.setImage(UIImage(named: "edit"), for: .normal)
        editPhotoBtn.setTitleColor(#colorLiteral(red: 0.3770111799, green: 0.8273198009, blue: 1, alpha: 1), for: .normal)
        editPhotoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        editPhotoBtn.addTarget(self, action: #selector(editPhotoPressed), for: .touchDown)
        editPhotoBtn.translatesAutoresizingMaskIntoConstraints = false
        return editPhotoBtn
    }()
    //UIImageView-GherasImage
    let GherasImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "rosette")
        imageView.tintColor = #colorLiteral(red: 0.04236891121, green: 0.6102550626, blue: 0.2603748143, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //Tableview
    let myTableView : UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 110
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    let dismissing : UIButton = {
        $0.setTitle("Go Back", for: .normal)
        $0.backgroundColor = .red
        $0.addTarget(self, action: #selector(dismissingfunc), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(UIButton())
    
    let bookmark : UIButton = {
//        $0.setTitleColor(#colorLiteral(red: 0.3770111799, green: 0.8273198009, blue: 1, alpha: 1), for: .normal)
//        $0.setTitle("مرجعيتي", for: .normal)
        $0.setImage(UIImage(named: "bookmark"), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        
        return $0
        
    }(UIButton())
    
    let setting : UIButton = {
        $0.setImage(UIImage(named: "setting"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        
        return $0
        
    }(UIButton())
    
    let line : UIImageView = {
        $0.image = UIImage(named: "line2")
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(UIImageView())
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if Auth.auth().currentUser?.email! != nil {
            self.loudData()
        }
    }
    @objc func dismissingfunc() {
        dismiss(animated: true, completion: nil)
    }
    // Not Logged in Functions
    @objc func profilrGoLogin() {
        let goVC = LoginViewController()
        goVC.modalPresentationStyle = .fullScreen
        present(goVC, animated: true, completion: nil)
    }
    @objc func profilrGoSignUp() {
        let goVC = SignUpViewController()
        goVC.modalPresentationStyle = .fullScreen
        present(goVC, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("dude?")
        
        
        if Auth.auth().currentUser?.email! == nil  {
            print("Hello")
            view.addSubview(loginButton)
            view.addSubview(SignUpButton)
            view.addSubview(dismissing)
            view.willRemoveSubview(userIcon)
            view.willRemoveSubview(nameLbl)
            view.willRemoveSubview(signOutBtn)
            
            NSLayoutConstraint.activate([
                dismissing.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
                dismissing.heightAnchor.constraint(equalToConstant: 50),
                dismissing.widthAnchor.constraint(equalToConstant: 70),
                dismissing.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
                
                loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                loginButton.widthAnchor.constraint(equalToConstant: 120),
                loginButton.heightAnchor.constraint(equalToConstant: 50),
                
                SignUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
                SignUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                SignUpButton.widthAnchor.constraint(equalToConstant: 120),
                SignUpButton.heightAnchor.constraint(equalToConstant: 50)
            ])
            self.loadUser()
        } else {
//            view.willRemoveSubview(loginButton)
//            view.willRemoveSubview(SignUpButton)
//            view.willRemoveSubview(dismissing)
            setupView()
            imagePicker.delegate = self
            
            myTableView.delegate = self
            myTableView.dataSource = self
            myTableView.register(PostTableViewCell.self, forCellReuseIdentifier: "reqCell")
            self.loadUser()
        }
        
                DispatchQueue.main.async {
                    self.loadUser()
                }
    }
    
    @objc func questionsView() {
        let vc = HomeViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func editPhotoPressed() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func signOut() {
        let alert = UIAlertController(title: "", message: "هل انت متأكد من تسجيل الخروج؟", preferredStyle: .alert)
        let signOutBtn = UIAlertAction(title: "تسجيل خروج", style: .destructive) { alertAction in
            do {
                try Auth.auth().signOut()
                //                                self.dismiss(animated: false, completion: nil)
                let vc = ProfileViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false, completion: nil)
            }catch {
                print("Error: ",error.localizedDescription)
            }
        }
        alert.addAction(signOutBtn)
        alert.addAction(UIAlertAction(title: "إلغاء", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: fetch user data
    func loadUser() {
        if let userId = userId {
            db.collection("Users").document(userId).getDocument { documentSnapshot, error in
                if let error = error {
                    print("Error: ",error.localizedDescription)
                }else {
                    self.nameLbl.text = documentSnapshot?.get("name") as? String ?? "nil"
                    //                    self.pointLbl.text = String(documentSnapshot?.get("point") as? Int ?? 0) + "_"
                    let imgStr = documentSnapshot?.get("userIcon") as? String
                    if imgStr == "nil" {
                        self.userIcon.image = UIImage(named: "icons8-Doodle-MXJBhIDosJsE-50-ffffff")
                    }
                    else {
                        self.loadImage(imgStr: imgStr!)
                        
                    }
                    
                    
                }
            }
        }
    }
    func loadImage(imgStr: String) {
        let url = "gs://pregnancies-01-01-2022.appspot.com/images/" + "\(imgStr)"
        
        let Ref = Storage.storage().reference(forURL: url)
        Ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                print("Error: Image could not download!")
                print(error?.localizedDescription)
            } else {
                self.userIcon.image = UIImage(data: data!)
            }
        }
    }
    
    //MARK: update user icon
    func updateUserIcon() {
        uploadImage()
        self.db.collection("Users")
            .document(userId!).updateData(
                [
                    "userIcon": userIcon.image == UIImage(systemName: "person.circle") ? "nil" : updateImageName
                ])
        {(error) in
            if error == nil {
                print("Added image Succ..")
            }else {
                print(error!.localizedDescription)
            }
        }
        
    }
    
    func uploadImage(){
        let imagefolder = Storage.storage().reference().child("images")
        if let imageData = userIcon.image?.jpegData(compressionQuality: 0.1) {
            imagefolder.child(updateImageName).putData(imageData, metadata: nil){
                (metaData , error) in
                if let error = error {
                    print(error.localizedDescription)
                }else {
                    print("update image Succ..")
                }
            }
        }
    }
    func loudData(){
        if let userID = userID {
            db.collection("Users").document(userID)
                .getDocument {
                    qurSnapShot, error in
                    
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        self.db.collection("Posts").order(by: "date", descending: true).addSnapshotListener({ qurySnapshot, error in
                            self.postArray = []
                            if let error = error {
                                print(error)
                            }else{
                                for doc in qurySnapshot!.documents {
                                    let data = doc.data()
                                    let timestamp: Timestamp = data["date"] as! Timestamp
                                    let datetest: Date = timestamp.dateValue()
                                    if (doc.get("usernamep")as? String ?? "nil") == (qurSnapShot?.get("username") as? String ?? "nil"){
                                        self.postArray.append(Posts(content: data["content"] as? String ?? "", username: data["usernamep"] as? String ?? "", link: data["link"] as? String ?? "" , date: datetest))}
                                    DispatchQueue.main.async {
                                        self.myTableView.reloadData()
                                    }
//                                    self.tableView.reloadData()
                                }
                            }
                        })
//                            .getDocuments { [self] (qurySnapshot, error) in
//                            if let error = error {
//                                print(error)
//                            }else{
//                                for doc in qurySnapshot!.documents {
//                                    let data = doc.data()
//                                    let timestamp: Timestamp = data["date"] as! Timestamp
//                                    let datetest: Date = timestamp.dateValue()
//                                    if (doc.get("usernamep")as? String ?? "nil") == (qurSnapShot?.get("username") as? String ?? "nil"){
//                                        self.postArray.append(Posts(content: data["content"] as? String ?? "", username: data["usernamep"] as? String ?? "", link: data["link"] as? String ?? "" , date: datetest))}
//                                    self.tableView.reloadData()
//                                }
//                            }
//                        }
//                        DispatchQueue.main.async {
//                            self.tableView.reloadData()
//                        }
                    }
                }
        }
    }
}
    
    //MARK: -UIImagePickerController
    extension ProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            userIcon.image = pickedImage
            updateUserIcon()
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    //MARK: -NSLayoutConstraint
    extension ProfileViewController {
        private func setupView() {
            view.addSubview(userIcon)
            view.addSubview(signOutBtn)
            view.addSubview(nameLbl)
            //        view.addSubview(GherasImage)
            //        view.addSubview(pointLbl)
            view.addSubview(editPhotoBtn)
            view.addSubview(bookmark)
            view.addSubview(myTableView)
            view.addSubview(setting)
            view.addSubview(line)
//            tableView.setEmptyMessage("لا توجد مشاركات، شارك الان 🎀")
//            if postArray != nil {
//                print("hidden massage")
//            } else if postArray == nil {
//                self.tableView.setEmptyMessage("لا توجد مشاركات، شارك الان 🎀")
//            } else {
//                print("اوووففف")
//            }
            
            
            NSLayoutConstraint.activate([
                signOutBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
                signOutBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -35),
                signOutBtn.heightAnchor.constraint(equalToConstant: 70),
                signOutBtn.widthAnchor.constraint(equalToConstant: 50),
                
                userIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
                userIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                userIcon.heightAnchor.constraint(equalToConstant: 150),
                userIcon.widthAnchor.constraint(equalToConstant: 150),
                
                nameLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 350),
                nameLbl.heightAnchor.constraint(equalToConstant: 35),
                nameLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -35),
                
                bookmark.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
                bookmark.widthAnchor.constraint(equalToConstant: 50),
                bookmark.heightAnchor.constraint(equalToConstant: 70),
                bookmark.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35),
                
                setting.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
                setting.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35),
                setting.widthAnchor.constraint(equalToConstant: 50),
                setting.heightAnchor.constraint(equalToConstant: 70),
                
                line.topAnchor.constraint(equalTo: nameLbl.topAnchor, constant: 20),
                line.widthAnchor.constraint(equalToConstant: 390),
                line.heightAnchor.constraint(equalToConstant: 50),
                line.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
                
//                bookmark.topAnchor.constraint(equalTo: nameLbl,)
                //            GherasImage.topAnchor.constraint(equalTo: nameLbl.bottomAnchor,constant: 8),
                //            GherasImage.trailingAnchor.constraint(equalTo: nameLbl.trailingAnchor),
                //            GherasImage.heightAnchor.constraint(equalToConstant: 25),
                //            GherasImage.widthAnchor.constraint(equalToConstant: 25),
                
                
                //            pointLbl.trailingAnchor.constraint(equalTo: GherasImage.leadingAnchor,constant: -5),
                //            pointLbl.heightAnchor.constraint(equalToConstant: 25),
                //            pointLbl.centerYAnchor.constraint(equalTo: GherasImage.centerYAnchor),
                
                editPhotoBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
                editPhotoBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -35),
                editPhotoBtn.heightAnchor.constraint(equalToConstant: 70),
                editPhotoBtn.widthAnchor.constraint(equalToConstant: 40),
                
                
                //++++
                myTableView.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 10 ),
                myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 20 ),
                myTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -20 ),
                myTableView.heightAnchor.constraint(equalToConstant: 350),
                
            ])
        }
    }
    
    
    extension ProfileViewController : UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if postArray.count == 0 {
                myTableView.backgroundView = viewStoryboard
            } else {
                myTableView.backgroundView = nil
            }
            
            return postArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reqCell", for: indexPath) as! PostTableViewCell
            // dateformatter
            let date = postArray[indexPath.row].date
            var stringDate = ""
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, yyyy"
            stringDate = formatter.string(from: date ?? Date())
            
            cell.dateCreated.text = stringDate
//            cell.usernamePoster.text = postArray[indexPath.row].username
            cell.contentPost.text = postArray[indexPath.row].content
            cell.linkPost.text = postArray[indexPath.row].link
            return cell
        }
        
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                let userEmail = Auth.auth().currentUser!.email!

                if (editingStyle == .delete) {
                    print("\(userEmail)-\(postArray[indexPath.row].content)")
                        db.collection("Posts").document("\(userEmail)-\(postArray[indexPath.row].content)").delete() { err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            let alert = UIAlertController(title: "", message: "تم حذف الماده  )", preferredStyle: .alert)
                            let action = UIAlertAction(title: "موافق", style: .default ,handler: { action in
                                
//                                self.postArray.remove(at: indexPath.row)
                                self.myTableView.reloadData()
                            })
                            alert.addAction(action)
                            self.present(alert, animated: true)
                            print("Document successfully removed!")
                        }
                    }
                }
        
    }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
    
    }
    
    
    
    
    
extension UITableView {
        
        func setEmptyMessage(_ message: String) {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
            messageLabel.text = message
            messageLabel.textColor = .black
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
            messageLabel.sizeToFit()
            
            self.backgroundView = messageLabel
            self.separatorStyle = .none
        }
        
        func restore() {
            self.backgroundView = nil
            self.separatorStyle = .singleLine
        }
    }
    
    
    
    
