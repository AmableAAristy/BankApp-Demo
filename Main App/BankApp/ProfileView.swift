//
//  ProfileView.swift
//  BankApp
//
//  Created by Amable A Aristy  on 7/5/24.
//


import SwiftUI
import Firebase
import FirebaseFirestoreSwift



struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var personalDetails:PersonalDetails?
    let db = Firestore.firestore()
    let userId = Auth.auth().currentUser?.uid ?? "SKXM8NNBc2SNUGJ7a8it8cVJpL72"
    
    
    
    var body: some View {
        
        NavigationStack{
            ProfileHeaderView(personalDetails: personalDetails)
            
            VStack {
                
                List {
                    NavigationLink(destination: PersonalDetailsView(personalDetails: personalDetails)) {
                        Label("Personal Details", systemImage: "person.fill")
                    }
                    NavigationLink(destination: MyCardsView()) {
                        Label("My Cards", systemImage: "creditcard.fill")
                    }
                    //leaving it as a comment until we all decide to take it out or not
                    //NavigationLink(destination: WithdrawalDetailsView()) {
                    //  Label("Withdrawal Details", systemImage: "arrow.down.circle.fill")
                    //}
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
                    do {
                        try Auth.auth().signOut()
                        
                        print("Logged out successfully.")
                        presentationMode.wrappedValue.dismiss()
                    } catch let signOutError as NSError {
                        print("Error signing out: \(signOutError)")
                    }                }) {
                        Text("Log Out")
                            .foregroundColor(.red)
                    }
                    .padding()
            }
            .navigationBarHidden(true)
        }
        .onAppear(perform: fetchProfileInfo)
    }
    func fetchProfileInfo() {
        
        db.collection("Accounts").document(userId).collection("UserInfo").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting User History: \(error)")
                return
            }
            
            guard (snapshot?.documents) != nil else {
                print("No documents found")
                return
            }
            
            self.personalDetails = snapshot?.documents.first.flatMap { try? $0.data(as: PersonalDetails.self)
            }
        }
    }
}

struct ProfileHeaderView: View {
    let personalDetails: PersonalDetails?
    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
            Text("\(personalDetails?.name ?? "")")
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
