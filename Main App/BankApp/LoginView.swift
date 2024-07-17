import SwiftUI
import Firebase

struct LoginView: View {
    @State private var isCreateAccountViewPresented = false
    @State private var isPasswordCorrect: Bool = false
    @State private var showErrorAlert: Bool = false
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Spacer()
                    
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        // Email
                        HStack {
                            Image(systemName: "mail")
                                .foregroundColor(.gray)
                            TextField("Email", text: $email)
                                .foregroundColor(.black)
                                .font(.title2)
                                .autocapitalization(.none)
                            
                            if !email.isEmpty {
                                Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
                                    .foregroundColor(email.isValidEmail() ? .green : .red)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        
                        // Password
                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(.gray)
                            SecureField("Password", text: $password)
                                .foregroundColor(.black)
                                .font(.title2)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    // Create Account Button
                    Button(action: {
                        isCreateAccountViewPresented.toggle()
                    }) {
                        Text("Create Account")
                            .foregroundColor(.blue)
                            .font(.title2)
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                    }
                    .sheet(isPresented: $isCreateAccountViewPresented) {
                        NewAccountView()
                    }
                    .padding(.horizontal, 30)
                    
                    // Login Button
                    Button(action: {
                        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                            if let error = error {
                                print(error)
                                email = ""
                                password = ""
                                showErrorAlert.toggle()
                            }
                            if authResult != nil {
                                isPasswordCorrect = true
                            }
                        }
                    }) {
                        Text("Login")
                            .foregroundColor(.white)
                            .font(.title2)
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                    .alert(isPresented: $showErrorAlert) {
                        Alert(title: Text("Error"), message: Text("Please check your email and password"), dismissButton: .default(Text("OK")))
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                }
                .padding()
            }
            
            NavigationLink(destination: ContentView(), isActive: $isPasswordCorrect) {
                EmptyView()
            }
        }
    }
}

#Preview {
    LoginView()
}
