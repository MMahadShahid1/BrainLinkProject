//
//  BookingViewController.swift
//  BrainLink
//
//  Created by Muhammad Mahad on 2025-03-29.
//

/** Here, I have multiple text fields, datepicker, picker and buttons
 The patient enters his data, picks the docter from a picker view.
 When book appointment is clicked, it checks if any field is empty.
 Else all values are pushed to firebase
 Clear button clears everyhting.
 
 Also I set up a rules on firebase to only push if user is authenticated!
 here I implemented email login uthing Authentication service on firestore
 
 mahadshahid@gmail.com
 123456
 */

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class BookingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var tfEMail: UITextField!
    @IBOutlet var tfPhone: UITextField!
    @IBOutlet var tfFirstName: UITextField!
    @IBOutlet var tfLastName: UITextField!
    @IBOutlet var tfAddress: UITextField!
    @IBOutlet var tfDescription: UITextView!
    @IBOutlet var tfDoctor: UITextField!
    @IBOutlet var dpDate: UIDatePicker!
    @IBOutlet var lblOutput: UILabel!
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    let db = Firestore.firestore()
    let picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        tfDoctor.inputView = picker
        
        mainDelegate.fetchDoctorDataFromFirebase() // here I am fetching the 6 doctors i put in firestore
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // here i added 1 second delay for cool animation delay 
            self.picker.reloadAllComponents()
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mainDelegate.doctorList.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mainDelegate.doctorList[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedDoctor = mainDelegate.doctorList[row]
        tfDoctor.text = selectedDoctor.name
        tfDoctor.resignFirstResponder()
    }
    
    @IBAction func submitAppointment(_ sender: UIButton) {
        guard let userId = Auth.auth().currentUser?.uid else {
            lblOutput.text = "Not logged in"
            lblOutput.textColor = .red
            return
        }

        if !areFieldsFilled() {
            lblOutput.text = "Please fill in all fields."
            lblOutput.textColor = .red
            return
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: dpDate.date)

        let formatterTime = DateFormatter()
        formatterTime.dateFormat = "h:mm a"
        let time = formatterTime.string(from: dpDate.date)

        // my fields for firestore
        let appointmentData: [String: Any] = [
            "patientId": userId,
            "firstName": tfFirstName.text ?? "",
            "lastName": tfLastName.text ?? "",
            "email": tfEMail.text ?? "",
            "phone": tfPhone.text ?? "",
            "address": tfAddress.text ?? "",
            "description": tfDescription.text ?? "",
            "doctor": tfDoctor.text ?? "",
            "date": date,
            "time": time,
            "timestamp": FieldValue.serverTimestamp()
        ]

        db.collection("appointments").addDocument(data: appointmentData) { error in // here is the data pushes and created a document
            self.lblOutput.text = "Appointment booked successfully!"
            self.lblOutput.textColor = .green
            self.clearFields()
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        clearFields()
    }

    func clearFields() {
        tfFirstName.text = ""
        tfLastName.text = ""
        tfEMail.text = ""
        tfPhone.text = ""
        tfAddress.text = ""
        tfDescription.text = ""
        tfDoctor.text = ""
        dpDate.date = Date()
    }
    
    //here it checks if all fields are completed
    func areFieldsFilled() -> Bool {
        return !(tfFirstName.text?.isEmpty ?? true) &&
               !(tfLastName.text?.isEmpty ?? true) &&
               !(tfEMail.text?.isEmpty ?? true) &&
               !(tfPhone.text?.isEmpty ?? true) &&
               !(tfAddress.text?.isEmpty ?? true) &&
               !(tfDescription.text?.isEmpty ?? true) &&
               !(tfDoctor.text?.isEmpty ?? true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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


