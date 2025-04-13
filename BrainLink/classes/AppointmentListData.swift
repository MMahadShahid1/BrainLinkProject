//
//  AppointmentListData.swift
//  BrainLink
//
//  Created by Muhammad Mahad on 2025-03-30.
//

import UIKit

class AppointmentListData: NSObject {
    var firstName: String?
    var lastName: String?
    var email: String?
    var phone: String?
    var date: String?
    var descriptionText: String?
    var doctor: String?
    
    func initWithData(first: String, last: String, email: String, phone: String, date: String, description: String, doctor: String) {
        self.firstName = first
        self.lastName = last
        self.email = email
        self.phone = phone
        self.date = date
        self.descriptionText = description
        self.doctor = doctor
    }
}
