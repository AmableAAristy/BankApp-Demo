import SwiftUI
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase

struct NewAccountView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showErrorAlert: Bool = false
    @State private var errorMessage:String = ""
    @State private var name:String = ""
    @State private var address:String = ""
    @State private var phone: String = ""
    @State private var dob: String = ""
    @State private var userId: String = ""
    
    let db = Firestore.firestore()
    
    var body: some View {
        
        VStack{
            Text("New Account")
                .font(.largeTitle)
            Spacer()
            
            HStack{
                
                Image(systemName: "mail")
                    .foregroundColor(.gray)
                TextField("Email", text:$email)
                    .foregroundColor(.gray)
                    .font(.title)
                    .fontWeight(.bold)
                
                if (email.count != 0){
                    Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
                        .frame(width: 30)
                        .fontWeight(.bold)
                        .foregroundColor(email.isValidEmail() ?.green : .red)
                }
                
                
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black)
                
            ).padding()
            
            HStack{
                
                Image(systemName: "lock")
                    .foregroundColor(.gray)
                TextField("Password", text:$password)
                    .foregroundColor(.gray)
                    .font(.title)
                    .fontWeight(.bold)
                
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black)
                
            ).padding()
            
            
            HStack{
                
                Image(systemName: "lock")
                    .foregroundColor(.gray)
                TextField("Full Name", text:$name)
                    .foregroundColor(.gray)
                    .font(.title)
                    .fontWeight(.bold)
                
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black)
                
            ).padding()
            
            HStack{
                
                Image(systemName: "lock")
                    .foregroundColor(.gray)
                TextField("Address", text:$address)
                    .foregroundColor(.gray)
                    .font(.title)
                    .fontWeight(.bold)
                
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black)
                
            ).padding()
            
            HStack{
                //see if you can make this into one of those menu things that you scroll
                Image(systemName: "lock")
                    .foregroundColor(.gray)
                TextField("Phone", text:$phone)
                    .foregroundColor(.gray)
                    .font(.title)
                    .fontWeight(.bold)
                
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black)
                
            ).padding()
            
            HStack{
                //see if you can make this into one of those menu things that you scroll
                Image(systemName: "lock")
                    .foregroundColor(.gray)
                TextField("Date of Birth", text:$dob)
                    .foregroundColor(.gray)
                    .font(.title)
                    .fontWeight(.bold)
                
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black)
                
            ).padding()
            
            HStack{
                
                Spacer()
                
                
                
                
                Button(action: {
                    
                    presentationMode.wrappedValue.dismiss()
                }){
                    Text("Cancel")
                        .foregroundColor(.gray)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }
                Spacer()
                
                Button(action: {
                    
                    
                    Auth.auth().createUser(withEmail: email, password: password){ authResult, error in
                        
                        if let error = error{
                            print("Error: \(error.localizedDescription)")
                            showErrorAlert.toggle()
                            errorMessage = error.localizedDescription
                            return
                        }
                        
                        
                        if let authResult = authResult{
                            userId = authResult.user.uid
                            print("User created: \(userId)")
                            addUserInfo(name: name, dob: dob, address: address, phone: phone, email: email)
                            
                            
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                }){
                    Text("Create Account")
                        .foregroundColor(.gray)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .alert(isPresented: $showErrorAlert) {
                            Alert(title:  Text(errorMessage))
                        }
                }
                Spacer()
            }
            
            Spacer()
            
        }//end Vstack
    }//end body
    func addUserInfo(name: String, dob: String, address: String, phone: String, email: String) {
        
        
        let newUser = PersonalDetails(name: name, dob: dob, address: address, phone: phone, email: email)
        
        let _ = try? db.collection("Accounts").document(userId).collection("UserInfo").addDocument(from: newUser) { error in
            if let error = error {
                print("Error writing Credit to Firestore: \(error)")
                
            }
        }//end view
    }
}
#Preview {
    NewAccountView()
}
