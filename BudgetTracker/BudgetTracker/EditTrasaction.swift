//
//  EditTrasaction.swift
//  BudgetTracker
//
//  Created by admin on 29/01/25.
//

import SwiftUI

struct EditTrasaction: View {
    @Environment(\.managedObjectContext) private var viewContext
       @Environment(\.dismiss) private var dismiss

       @ObservedObject var transaction: Trasaction
        @State private var amount=""
       @State private var desc = ""
        @State private var category = ""

       var body: some View {
           NavigationView {
               Form {
                   Section(header: Text("Edit Title")) {
                       TextField("Edit post title", text: $amount)
                       TextField("Edit post desc", text: $desc)
                   }
               }
               .navigationBarTitle("Edit Post", displayMode: .inline)
               .navigationBarItems(
                   leading: Button("Cancel") {
                       dismiss()
                   },
                   trailing: Button("Update") {
                       if let isdouble=Double(amount){
                           transaction.amount=isdouble
                       }else{
                           transaction.amount=0.0
                       }
                       
                       transaction.desc = desc
                       saveContext()
                       dismiss()
                   }.disabled(desc.isEmpty)
               )
               .onAppear {
                   amount = String(format: "%.2f", transaction.amount)
                   desc = transaction.desc ?? ""
               }
           }
       }

       private func saveContext() {
           do {
               try viewContext.save()
           } catch {
               print("Error saving context: \(error)")
           }
       }
   
}

