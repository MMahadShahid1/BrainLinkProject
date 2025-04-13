//
//  AppDelegate.swift
//  BrainLink
//
//  Created by Muhammad Mahad on 2025-03-21.
//

import UIKit
import Firebase
import FirebaseFirestore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var doctorList: [DoctorData] = [] // i put 6 doctors on forestore
    var appointmentsForDoctor: [AppointmentListData] = [] // using a list

    func fetchDoctorDataFromFirebase() {
        let db = Firestore.firestore()
        doctorList.removeAll()

        db.collection("doctors").getDocuments { snapshot, error in
            guard let docs = snapshot?.documents
            else {
                return
            }

            for doc in docs {
                let data = doc.data()

                if let name = data["name"] as? String{
                    let d = DoctorData()
                    d.initWithData(theName: name)
                    self.doctorList.append(d)
                }
            }
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

