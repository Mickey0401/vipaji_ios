//
//  SignUpViewController.swift
//  vipaji
//
//  Created by Mickey on 1/28/18.
//  Copyright © 2018 Mickey. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet var ViewBg: UIView!
    @IBOutlet weak var ImageIcon: UIImageView!
    @IBOutlet weak var FieldName: SkyFloatingLabelTextField!
    @IBOutlet weak var FieldEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var FieldPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var LabelError: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ViewBg.addGradientBackground()
        ImageIcon.layer.cornerRadius = ImageIcon.frame.width / 2.0
        ImageIcon.clipsToBounds = true
        self.LabelError.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AttemptSignUp(_ sender: Any) {
        if FieldName.text! == "" || FieldName.text! == "" || FieldPassword.text == ""{
            self.LabelError.text = "please provide a valid name, email and password"
            self.LabelError.isHidden = false
        } else{
            Auth.auth().createUser(withEmail: FieldEmail.text!, password: FieldPassword.text!){(user, error) in
                if error == nil{
                    let user = Auth.auth().currentUser
                    if let user = user {
                        let changeRequest = user.createProfileChangeRequest()
                        
                        changeRequest.displayName = self.FieldName.text
                        changeRequest.commitChanges { error in
                            if let error = error {
                                // An error happened.
                                print(error.localizedDescription)
                            } else {
                                // Profile updated, add user to DB
                                //UserManager.createUser(user)
                            }
                        }
                    }
                }else{
                    // Sign up failed, display error message
                    self.LabelError.text = error?.localizedDescription
                    self.LabelError.isHidden = false
                }
                
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
