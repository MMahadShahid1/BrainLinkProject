//
//  DoctorRegisterViewController.swift
//  BrainLink
//
//  Created by Muhammad Mahad on 2025-03-22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class DoctorRegisterViewController: UIViewController {

    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPassword: UITextField!
    @IBOutlet var lblMessage: UILabel!
    
    let database = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblMessage.text = ""
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
            doctorRegister()
    }
    
    private func doctorRegister() {
        guard let email = tfEmail.text, !email.isEmpty,
              let password = tfPassword.text, !password.isEmpty
        else {
            lblMessage.text = "All fields are required!"
            lblMessage.textColor = .red
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) {
            authResult, error in
            if let error = error {
                self.lblMessage.text = "Error: \(error.localizedDescription)"
                self.lblMessage.textColor = .red
            } else {
                guard let uid = authResult?.user.uid
                else {
                    return
                }
                                    
                self.database.collection("users").document(uid).setData([
                    "uid": uid, "email": email, "role": "doctor"]) { error in
                        self.lblMessage.text = "Doctor registered successfully!"
                        self.lblMessage.textColor = .green
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
