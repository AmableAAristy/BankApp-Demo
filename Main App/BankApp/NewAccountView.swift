import SwiftUI
import FirebaseAuth


struct NewAccountView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showErrorAlert: Bool = false
    @State private var errorMessage:String = ""
    
    
    
    
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
                            print("User created: \(authResult.user.uid)")
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
}//end view

#Preview {
    NewAccountView()
}
