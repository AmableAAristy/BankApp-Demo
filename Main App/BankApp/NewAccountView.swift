import SwiftUI
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase

struct NewAccountView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showErrorAlert: Bool = false
    @State private var errorMessage: String = ""
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var phone: String = ""
    @State private var dob: String = ""
    @State private var userId: String = ""
    
    var isFormValid: Bool {
           return email.isValidEmail() && dob.isValidBirthday() && phone.isValidPhoneNumber()
       }
    
    let db = Firestore.firestore()
    
    var body: some View {
        ScrollView{
            Color.white
                .edgesIgnoringSafeArea(.all)
                        
                        VStack(spacing: 5) {
                            Spacer()
                            
                            Text("New Account")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            /*
                             .foregroundColor(.white)
                             .font(.title2)
                             .bold()
                             .padding()
                             .frame(maxWidth: .infinity)
                             .background(Color.gray)
                             .cornerRadius(10)
                             .shadow(radius: 10)
                             */
                            
                            Group {
                                CustomTextField(imageName: "mail", placeholder: "Email", text: $email, isValid: email.isValidEmail())
                                    
                                CustomTextField(imageName: "lock", placeholder: "Password", text: $password, isSecure: true)
                                
                                CustomTextField(imageName: "person", placeholder: "Full Name", text: $name)
                                
                                CustomTextField(imageName: "house", placeholder: "Address", text: $address)
                                
                                CustomTextField(imageName: "phone", placeholder: "Phone", text: $phone, isValid: phone.isValidPhoneNumber())
                                
                                CustomTextField(imageName: "calendar", placeholder: "Date of Birth", text: $dob, isValid: dob.isValidBirthday())
                                    
                            }
                            .padding(.horizontal, 10)
                            
                            Spacer()
                            
                            VStack(spacing: 10) {
                                // Cancel Button
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Text("Cancel")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                        .bold()
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.gray)
                                        .cornerRadius(10)
                                        .shadow(radius: 10)
                                }
                                
                                // Create Account Button
                                Button(action: {
                                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                                        if let error = error {
                                            print("Error: \(error.localizedDescription)")
                                            showErrorAlert.toggle()
                                            errorMessage = error.localizedDescription
                                            return
                                        }
                                        
                                        if let authResult = authResult {
                                            userId = authResult.user.uid
                                            print("User created: \(userId)")
                                            addUserInfo(name: name, dob: dob, address: address, phone: phone, email: email)
                                        }
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }) {
                                    Text("Create Account")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                        .bold()
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(isFormValid ? Color.blue : Color.gray)
                                        .cornerRadius(10)
                                        .shadow(radius: 10)
                                }
                                .disabled(!isFormValid)
                                .alert(isPresented: $showErrorAlert) {
                                    Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                                }
                            }
                            .padding(.horizontal, 30)
                            
                            Spacer()
                        }
                        .padding()
                    }
    }//end ScrollView
    
    func addUserInfo(name: String, dob: String, address: String, phone: String, email: String) {
        let newUser = PersonalDetails(name: name, dob: dob, address: address, phone: phone, email: email)
        let _ = try? db.collection("Accounts").document(userId).collection("UserInfo").addDocument(from: newUser) { error in
            if let error = error {
                print("Error writing Credit to Firestore: \(error)")
            }
        }
    }
}

struct CustomTextField: View {
    let imageName: String
    let placeholder: String
    @Binding var text: String
    var isValid: Bool? = nil
    var isSecure: Bool = false

    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.gray)
            if isSecure {
                SecureField(placeholder, text: $text)
                    .foregroundColor(.gray)
                    .font(.title)
                    .fontWeight(.bold)
            } else {
                TextField(placeholder, text: $text)
                    .foregroundColor(.gray)
                    .font(.title)
                    .fontWeight(.bold)
            }
            if let isValid = isValid, text.count != 0 {
                Image(systemName: isValid ? "checkmark" : "xmark")
                    .frame(width: 30)
                    .fontWeight(.bold)
                    .foregroundColor(isValid ? .green : .red)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
                .foregroundColor(.black)
        )
        .padding()
    }
}

struct NewAccountView_Previews: PreviewProvider {
    static var previews: some View {
        NewAccountView()
    }
}
