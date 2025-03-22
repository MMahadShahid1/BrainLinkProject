//
//  PatientLoginViewController.swift
//  BrainLink
//
//  Created by Muhammad Mahad on 2025-03-22.
//

import UIKit
import FirebaseAuth

class PatientLoginViewController: UIViewController {

    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPassword: UITextField!
    @IBOutlet var lblmessage: UILabel!
    
    
    
    @IBAction func unwindToPatientLoginVC(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        patientLogin()
    }
    private func patientLogin() {
        guard let email = tfEmail.text, !email.isEmpty,
        let password = tfPassword.text, !password.isEmpty
        else {
            lblmessage.text = "All fields are required!"
            lblmessage.textColor = .red
                    
            return
        }

        // MARK: Firebase Login
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.lblmessage.text = "Error: \(error.localizedDescription)"
                self.lblmessage.textColor = .red
            }
            else {
                self.lblmessage.text = "Login successful!"
                self.lblmessage.textColor = .green
                        
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblmessage.text = ""
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
