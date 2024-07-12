//
//  CloseAccountView.swift
//  BankApp
//
//  Created by ethan b on 7/9/24.
//

import Foundation
import SwiftUI

struct CloseAccountView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Close Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)

                Section(header: Text("Steps to Close Your Account").font(.title2).fontWeight(.bold)) {
                    Text("1. Ensure all pending transactions are completed.")
                    Text("2. Transfer any remaining balance to another account.")
                    Text("3. Gather necessary documentation, such as a valid ID.")
                    Text("4. Contact customer support to initiate the closure process.")
                }

                Section(header: Text("Consequences of Closing Your Account").font(.title2).fontWeight(.bold)) {
                    Text("Closing your account will result in the following:")
                    Text("• Any remaining balance will be transferred to your linked account.")
                    Text("• Linked services such as loans or credit cards will be affected.")
                    Text("• You may incur fees or penalties for early closure.")
                }

                Section(header: Text("Contact Information").font(.title2).fontWeight(.bold)) {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "phone.fill")
                                .foregroundColor(.blue)
                                .frame(width: 30, height: 30)
                            Text("Customer Service: 1-800-123-4567")
                        }
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.blue)
                                .frame(width: 30, height: 30)
                            Text("Email: support@bank.com")
                        }
                        HStack {
                            Image(systemName: "message.fill")
                                .foregroundColor(.blue)
                                .frame(width: 30, height: 30)
                            Text("Live Chat: Available 24/7")
                        }
                    }
                    .padding(.vertical, 10)
                }

                Button(action: {
                    // Action to initiate account closure
                }) {
                    Text("Initiate Account Closure")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding(.vertical, 20)
            }
            .padding()
        }
        .navigationBarTitle("Close Account", displayMode: .inline)
    }
}

#Preview {
    CloseAccountView()
}
