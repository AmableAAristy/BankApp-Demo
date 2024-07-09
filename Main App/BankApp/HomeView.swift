//
//  HomeView.swift
//  BankingApp
//
//  Created by Angie Martinez on 7/5/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var totalBalance: Double = 25000.0 // Example total balance

    var savingsAmount: Double {
        return totalBalance * 0.4 // 40% to savings
    }

    var creditAmount: Double {
        return totalBalance * 0.5 // 50% to credit
    }

    var investmentAmount: Double {
        return totalBalance * 0.2 // 20% to investment
    }
    
    var body: some View {
        
        NavigationStack{
            ScrollView{
                VStack {
                    // Header
                    HStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .padding(.trailing, 10)
                        
                        Text("Welcome John!")
                            .font(.title2).bold()
                        
                        Spacer()
                        
                        HStack(spacing: 30) {
                            Image(systemName: "bell.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                            
                            Image(systemName: "gear")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    Spacer().frame(height: 30)
                    
                    Text("Account Balance")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.bottom, 5)
                        .padding(.top, 15)
                    
                    // Account balance section
                    VStack(alignment: .leading) {
                        
                        HStack {
                            
                            Text("$\(totalBalance, specifier: "%.2f")")
                                .font(.largeTitle).bold()
                                .padding(-15)
                        }
                        .padding()
                        
                    }//end VStack
                    .padding(.horizontal)
                    
                    Spacer().frame(height: 30)
                    
                    // Actions section
                    HStack(spacing: 30) {
                        VStack {
                            ZStack {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 48, height: 48)
                                
                                Image(systemName: "square.and.arrow.down")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.white)
                            }
                            
                            Text("Withdraw")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        VStack {
                            ZStack {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 48, height: 48)
                                
                                Image(systemName: "paperplane.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.white)
                            }//end zstack
                            
                            Text("Transfer")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }//end vstack
                        
                        VStack {
                            ZStack {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 48, height: 48)
                                
                                Image(systemName: "creditcard.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.white)
                            }//end ZStack
                            
                            Text("Deposit")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }//end VStack
                    }//end HStack
                    .padding()
                    
                    // Rectangles with arrows section
                    VStack(spacing: 20) {
                        NavigationLink(destination: SavingsView()) {
                            HStack {
                                VStack(alignment: .leading){
                                    Text("Savings")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text("$\(savingsAmount, specifier: "%.2f")")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }//end vstack
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                            }//end HStack
                            .padding()
                            .frame(height: 100)
                            .background(Color.blue)
                            .cornerRadius(10)
                        }// end Nav Link
                        
                        NavigationLink(destination: TransactionView()) {
                            HStack {
                                VStack(alignment: .leading){
                                    Text("Credit")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text("$\(creditAmount, specifier: "%.2f")")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }//end vstack
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                            }//end HStack
                            .padding()
                            .frame(height: 100)
                            .background(Color.blue)
                            .cornerRadius(10)
                        }//end Nav Link
                        
                        NavigationLink(destination: StockView()) {
                            HStack {
                                VStack(alignment: .leading){
                                    Text("Stocks")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text("$\(investmentAmount, specifier: "%.2f")")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }//end vstack
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                            }//end HStack
                            .padding()
                            .frame(height: 100)
                            .background(Color.blue)
                            .cornerRadius(10)
                        }//end NavLink
                    }//end VStack
                    .padding(.horizontal)
                    
                    Spacer()
                }//end vstack
                .padding()
            }//end ScrollView
        }//end Nav Stack
        
    }//end body
}//end HomeView

#Preview {
    HomeView()
}
