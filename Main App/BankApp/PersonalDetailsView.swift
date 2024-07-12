//
//  PersonalDetailsView.swift
//  BankApp
//
//  Created by Angie Martinez on 7/11/24.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct BlankView: View {
    
    
    
    var body: some View {
        Text("This is a blank page")
            .navigationBarTitle("Details", displayMode: .inline)
    }
}

struct PersonalDetailsView: View {
    
    let personalDetails:PersonalDetails?
    let db = Firestore.firestore()
    let userId = Auth.auth().currentUser?.uid ?? "X5otVt63WoLW2fgE8TiY"
    
    var body: some View {
        
        Form {
            Section(header: Text("Personal Information")) {
                HStack {
                    Text("Full Name")
                    Spacer()
                    Text("\(personalDetails?.name ?? "John Doe")")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Date of Birth")
                    Spacer()
                    Text("\(personalDetails?.dob ?? "01/17/1998")")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Address")
                    Spacer()
                    Text("\(personalDetails?.address ?? "13452 NW 152nd Ave")")
                        .foregroundColor(.gray)
                        .lineLimit(2)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Phone Number")
                    Spacer()
                    Text("\(personalDetails?.phone ?? "(305) 767-2312")")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Email Address")
                    Spacer()
                    Text("\(personalDetails?.email  ?? "johnsmith@gmail.com")")
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .truncationMode(.middle)
                }
            }
        }
        
        .navigationBarTitle("Personal Details", displayMode: .inline)
    }
    

}

//#Preview {
  //  PersonalDetailsView()
//}

