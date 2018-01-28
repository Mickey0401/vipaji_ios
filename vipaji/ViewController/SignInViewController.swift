//
//  SignInViewController.swift
//  vipaji
//
//  Created by Mickey on 1/28/18.
//  Copyright © 2018 Mickey. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet var ViewBg: UIView!
    @IBOutlet weak var ImageIcon: UIImageView!
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
    
    @IBAction func AttemptSignIn(_ sender: Any) {
        if FieldEmail.text == "" || FieldPassword.text == "" {
            LabelError.text = "Please enter a valid email and password"
            LabelError.isHidden = false
        } else {
            Auth.auth().signIn(withEmail: FieldEmail.text!, password: FieldPassword.text!) { (user, error) in
                if error == nil {
                    //Present Home Controller
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabController")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else { //Login failed
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
