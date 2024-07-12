//
//  ProfileView.swift
//  BankApp
//
//  Created by Amable A Aristy  on 7/5/24.
//


import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            ProfileHeaderView()
            List {
                NavigationLink(destination: PersonalDetailsView()) {
                    Label("Personal Details", systemImage: "person.fill")
                }
                NavigationLink(destination: MyCardsView()) {
                    Label("My Cards", systemImage: "creditcard.fill")
                }
                NavigationLink(destination: WithdrawalDetailsView()) {
                    Label("Withdrawal Details", systemImage: "arrow.down.circle.fill")
                }
                NavigationLink(destination: NotificationsView()) {
                    Label("Notifications", systemImage: "bell.fill")
                }
                NavigationLink(destination: PrivacyAndSecurityView()) {
                    Label("Privacy and Security", systemImage: "lock.fill")
                }
                NavigationLink(destination: CustomerSupportView()) {
                    Label("Customer Support", systemImage: "phone.fill")
                }
                NavigationLink(destination: CloseAccountView()) {
                    Label("Close Account", systemImage: "xmark.circle.fill")
                }
            }
            .listStyle(InsetGroupedListStyle())
            Button(action: {
                // Log out action
            }) {
                Text("Log Out")
                    .foregroundColor(.red)
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}

struct ProfileHeaderView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
            Text("John Smith")
                .font(.title)
                .fontWeight(.bold)
            Spacer().frame(height: 20)
        }
        .padding()
    }
}

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
    ProfileView()
}
