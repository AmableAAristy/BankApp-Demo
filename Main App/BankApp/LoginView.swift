import SwiftUI
import Firebase

struct LoginView: View {
    @State private var isCreateAccountViewPresented = false
    @State private var isPasswordCorrect: Bool = false
    @State private var showErrorAlert: Bool = false
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    
    var body: some View {
        
        NavigationStack{
            
            
            
            ZStack{
                
                //Image("LoginBackGround")
                  //  .resizable()
                    //.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                
                VStack{
                    
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    Spacer()
                    Spacer()
                    
                    //email
                    HStack{
                        
                        Image(systemName: "mail")
                            .foregroundColor(.white)
                        TextField("Email", text:$email)
                            .foregroundColor(.black)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        
                        if(email.count != 0){
                            Image(systemName: email.isValidEmail() ? "checkmark": "xmark")
                                .frame(width: 30)
                                .fontWeight(.bold)
                                .foregroundColor(email.isValidEmail() ?.green : .red)
                        }
                        
                    }
                    .padding()
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.white)
                    }.padding()
                    
                    //password
                    HStack{
                        
                        Image(systemName: "lock")
                            .foregroundColor(.white)
                        TextField("Password", text: $password)
                            .foregroundColor(.black)
                            .font(.title)
                            .fontWeight(.bold)
                        
                    }.padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.white)
                            
                        ).padding()
                    
                    //new account button
                    
                    Button(action: {
                        isCreateAccountViewPresented.toggle()
                    }){
                        Text("Create Account")
                    }.foregroundColor(.black)
                        .font(.title)
                        .sheet(isPresented: $isCreateAccountViewPresented) {
                            NewAccountView()
                        }
                    
                    //spacers
                    Spacer()
                    Spacer()
                    
                    //login button
                    Button(action: {
                        
                        Auth.auth().signIn(withEmail: email, password: password){ authResult, error in
                            
                            if let error = error{
                                print(error)
                                email = ""
                                password = ""
                                showErrorAlert.toggle()
                                
                            }
                            
                            if let authResult = authResult{
                                isPasswordCorrect = true
                            }
                        }
                        
                        
                    }) {
                        
                        
                        Text("Login")
                            .foregroundColor(.white)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                    .fill(Color.black)
                                    .foregroundColor(.black)
                                    .opacity(0.5)
                            ).padding(.horizontal)
                        
                            .alert(isPresented: $showErrorAlert, content:{
                                Alert(title: Text("Error login please check mail and password"))
                            })
                        
                    }
                    .padding()
                    .padding(.top)
                    
                    
                    
                }
            }
            
            NavigationLink(destination: ContentView(), isActive: $isPasswordCorrect){
                EmptyView()
            }
            
        }
    }
}

#Preview {
    LoginView()
}
