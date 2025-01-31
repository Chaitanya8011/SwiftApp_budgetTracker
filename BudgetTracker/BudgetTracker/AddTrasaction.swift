//
//  AddTrasaction.swift
//  BudgetTracker
//
//  Created by admin on 28/01/25.

import SwiftUI

struct AddTrasaction: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var amount = ""
    @State private var desc = ""
    @State private var category = "income" 
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Transaction Details")) {
                    TextField("Enter amount", text: $amount)
                        .keyboardType(.decimalPad) // Ensure numeric keyboard
                    TextField("Enter description", text: $desc)
                    
                    Picker("Category", selection: $category) {
                        Text("Income").tag("income")
                        Text("Expense").tag("expense")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Add New Transaction", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Save") {
                    addTransaction()
                    dismiss()
                }
                .disabled(amount.isEmpty || desc.isEmpty)
            )
        }
    }
    
    private func addTransaction() {
        let newTransaction = Trasaction(context: viewContext)
        
        newTransaction.id = UUID()
        newTransaction.desc = desc
        newTransaction.category = category
        
        if let isDouble = Double(amount) {
            newTransaction.amount = isDouble
        } else {
            newTransaction.amount = 0.0
        }
        
        do {
            try viewContext.save()
            desc = ""
            amount = ""
            category = ""
        } catch {
            print("Error saving transaction: \(error)")
        }
    }
}

struct AddTrasaction_Previews: PreviewProvider {
    static var previews: some View {
        AddTrasaction()
    }
}
