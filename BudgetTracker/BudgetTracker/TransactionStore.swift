//
//  TransactionStore.swift
//  BudgetTracker
//
//  Created by admin on 28/01/25.
//

import Foundation

struct Transaction : Identifiable{
    let id = UUID()
    let amount: Double
    let  catagory: String
    let description: String
}

class TransactionStore: ObservableObject{
    @Published var transaction:[Transaction]=[]
    
    var totalIncome:Double{
        transaction.filter{$0.catagory=="Income"}.reduce(0){$0+$1.amount}
    }
    
    var totalExpense:Double{
        transaction.filter{$0.catagory=="Expense"}.reduce(0){$0+$1.amount}
    }
    var currentBalance:Double{
        totalIncome-totalExpense
    }
}
