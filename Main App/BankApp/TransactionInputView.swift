import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct TransactionInputView: View {
    @State var company: String = ""
    @State var costString: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    let db = Firestore.firestore()
    let userId = Auth.auth().currentUser?.uid ?? "SKXM8NNBc2SNUGJ7a8it8cVJpL72"
    
    
    var isCostValid: Bool {
        costString.isValidDouble()
    }
    
    var body: some View {
        VStack {
            TextField("Who did you do the transaction with?", text: $company)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack{
                TextField("For how much?", text: $costString)
                    .keyboardType(.decimalPad)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                if !costString.isEmpty{
                    Image(systemName: isCostValid ? "checkmark" : "xmark")
                        .frame(width: 30)
                        .fontWeight(.bold)
                        .foregroundColor(isCostValid ? .green : .red)
                }
            }
        }
        
        Button(action: {
            if let cost = Double(costString){
                addTransaction(company: company, price: cost)
                company = ""
                costString = ""
                presentationMode.wrappedValue.dismiss()
            } else {
                
                print("Invalid cost input")
            }
        }) {
            Text("Submit Amount")
                .frame(maxWidth: .infinity)
                .padding()
                .background(isCostValid ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .disabled(!isCostValid)
        .padding()
    }
    
    func addTransaction(company: String, price: Double) {
        
        
        let newTransaction = Transaction(company: company, price: -price, timestamp: Timestamp(date: Date()))
        
        do {
            let _ = try db.collection("Accounts").document(userId).collection("Credit").addDocument(from: newTransaction) { error in
                if let error = error {
                    print("Error writing Credit to Firestore: \(error)")
                }
            }
        } catch let error {
            print("Error writing transaction to Firestore: \(error)")
        }
    }//end add
}


#Preview {
    
    return VStack {
        TransactionInputView()
    }
}
