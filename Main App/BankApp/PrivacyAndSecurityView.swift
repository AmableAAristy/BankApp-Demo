//
//  PrivacyAndSecurityView.swift
//  BankApp
//
//  Created by ethan b on 7/9/24.
//

import SwiftUI

struct PrivacyAndSecurityView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Privacy and Security")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)

                Section(header: Text("Change Password").font(.title2).fontWeight(.bold)) {
                    Text("To change your password, go to the settings page and select 'Change Password'. Follow the instructions to create a new, strong password.")
                }

                Section(header: Text("Privacy Policy").font(.title2).fontWeight(.bold)) {
                    Text("Our privacy policy explains how we collect, use, and share your personal information. We value your trust and are committed to protecting your privacy.")
                }

                Section(header: Text("User Rights").font(.title2).fontWeight(.bold)) {
                    Text("You have the right to access, update, or delete your personal information. Please contact our support team for assistance.")
                }
            }
            .padding()
        }
        .navigationBarTitle("Privacy and Security", displayMode: .inline)
    }
}

#Preview {
    PrivacyAndSecurityView()
}
