//
//  AppointmentListViewController.swift
//  BrainLink
//
//  Created by Muhammad Mahad on 2025-03-29.
//


/**
 tableview shows a list of appointments posted by patient through firebase
 */
import UIKit
import FirebaseFirestore
import FirebaseAuth

class AppointmentListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    let db = Firestore.firestore()


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.appointmentsForDoctor.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let appointment = mainDelegate.appointmentsForDoctor[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "appointCell", for: indexPath) as! AppointListTableViewCell
        cell.nameLbl.text = "Name: \(appointment.firstName ?? "") \(appointment.lastName ?? "")"
        cell.emailLbl.text = "Email: \(appointment.email ?? "")"
        cell.phoneLbl.text = "Phone: \(appointment.phone ?? "")"
        cell.dateLbl.text = "Date: \(appointment.date ?? "")"
        cell.descriptionLbl.text = "Reason: \(appointment.descriptionText ?? "")"
        cell.doctorLbl.text = "Doctor: \(appointment.doctor ?? "")"

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

 
    func fetchAppointments() { // here I retrieve the data I pushed to firestore from BookingVC
        mainDelegate.appointmentsForDoctor.removeAll()

        db.collection("appointments").getDocuments { snapshot, error in  // appointments collection on firestore
            if let error = error {
                print("Firestore error: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else {
                print("No appointments")
                return
            }

            for doc in documents {
                let data = doc.data()

                let appointment = AppointmentListData()
                appointment.initWithData(
                    first: data["firstName"] as? String ?? "",
                    last: data["lastName"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    phone: data["phone"] as? String ?? "",
                    date: data["date"] as? String ?? "",
                    description: data["description"] as? String ?? "",
                    doctor: data["doctor"] as? String ?? ""
                )
                self.mainDelegate.appointmentsForDoctor.append(appointment)
            }

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAppointments()
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

