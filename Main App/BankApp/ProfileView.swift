//
//  ProfileView.swift
//  BankApp
//
//  Created by Amable A Aristy  on 7/5/24.
//


import SwiftUI

struct ProfileView: View {
    var body: some View {
        
        NavigationStack{
            ProfileHeaderView()
            
            VStack {
                
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


#Preview {
    ProfileView()
}
