//
//  PersonalDetailsView.swift
//  BankApp
//
//  Created by Angie Martinez on 7/11/24.
//

import SwiftUI

struct BlankView: View {
    var body: some View {
        Text("This is a blank page")
            .navigationBarTitle("Details", displayMode: .inline)
    }
}

struct PersonalDetailsView: View {
    var body: some View {
        Form {
            Section(header: Text("Personal Information")) {
                HStack {
                    Text("Full Name")
                    Spacer()
                    Text("John Samuel Smith")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Date of Birth")
                    Spacer()
                    Text("01/17/1998")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Address")
                    Spacer()
                    Text("13452 NW 152nd Ave")
                        .foregroundColor(.gray)
                        .lineLimit(2)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Phone Number")
                    Spacer()
                    Text("(305) 767-2312")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Email Address")
                    Spacer()
                    Text("johnsmith@gmail.com")
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .truncationMode(.middle)
                }
            }
        }
        .navigationBarTitle("Personal Details", displayMode: .inline)
    }
}

#Preview {
    PersonalDetailsView()
}
