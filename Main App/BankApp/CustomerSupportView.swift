//
//  CustomerSupportView.swift
//  BankApp
//
//  Created by ethan b on 7/9/24.
//

import Foundation
import SwiftUI

struct CustomerSupportView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Customer Support")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
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

                Section(header: Text("Frequently Asked Questions (FAQs)").font(.title2).fontWeight(.bold)) {
                    VStack(alignment: .leading) {
                        Text("Q: How do I reset my password?")
                        Text("A: To reset your password, go to the settings page and select 'Change Password'.")
                            .padding(.bottom, 5)
                        Text("Q: How do I contact customer support?")
                        Text("A: You can reach us via phone, email, or live chat 24/7.")
                            .padding(.bottom, 5)
                        Text("Q: How do I report a lost or stolen card?")
                        Text("A: Call our customer service immediately at 1-800-123-4567.")
                            .padding(.bottom, 5)
                    }
                    .padding(.vertical, 10)
                }

                Section(header: Text("Support Tickets").font(.title2).fontWeight(.bold)) {
                    VStack(alignment: .leading) {
                        Text("Submit a new support ticket or check the status of an existing ticket.")
                        Button(action: {
                            // Action to submit or check support tickets
                        }) {
                            Text("Manage Support Tickets")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.vertical, 10)
                }

                Section(header: Text("Branches and ATMs").font(.title2).fontWeight(.bold)) {
                    VStack(alignment: .leading) {
                        Text("Find nearby branches and ATMs using our locator tool.")
                        Button(action: {
                            // Action to open branch and ATM locator
                        }) {
                            Text("Find Branches and ATMs")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.vertical, 10)
                }

                Section(header: Text("Help Articles and Guides").font(.title2).fontWeight(.bold)) {
                    VStack(alignment: .leading) {
                        Text("Explore detailed articles and guides to help you manage your account and use our services.")
                        Button(action: {
                            // Action to open help articles and guides
                        }) {
                            Text("View Help Articles")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.vertical, 10)
                }

                Section(header: Text("Feedback and Suggestions").font(.title2).fontWeight(.bold)) {
                    VStack(alignment: .leading) {
                        Text("We value your feedback and suggestions. Please let us know how we can improve our services.")
                        Button(action: {
                            // Action to submit feedback
                        }) {
                            Text("Submit Feedback")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.vertical, 10)
                }

                Section(header: Text("Service Status").font(.title2).fontWeight(.bold)) {
                    VStack(alignment: .leading) {
                        Text("Check the current status of our services, including any outages or scheduled maintenance.")
                        Button(action: {
                            // Action to view service status
                        }) {
                            Text("View Service Status")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.vertical, 10)
                }
            }
            .padding()
        }
        .navigationBarTitle("Customer Support", displayMode: .inline)
    }
}



#Preview {
    CustomerSupportView()
}
