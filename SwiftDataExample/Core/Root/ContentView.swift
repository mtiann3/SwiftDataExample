//
//  ContentView.swift
//  SwiftDataExample
//
//  Created by Mike Iannotti on 3/24/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    @State private var isShowingItemSheet = false
    @Query(filter: #Predicate<Expense> { $0.value>1000}, sort: \Expense.date)
    var expenses: [Expense]
    @State private var expenseToEdit: Expense?
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(expenses){ expense in
                    ExpenseCell(expense: expense)
                        .onTapGesture {
                            expenseToEdit = expense
                        }
                }
                .onDelete{ indexSet in
                    for index in indexSet {
                        context.delete(expenses[index])
                        
                    }
                }
            }
            .navigationTitle("Expenses")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isShowingItemSheet) {
                AddExpenseSheet()
            }
            .sheet(item: $expenseToEdit) { expense in
                UpdateExpenseSheet(expense: expense)
            }
            .toolbar {
                if !expenses.isEmpty {
                    Button("Add Expense", systemImage: "plus"){
                        isShowingItemSheet = true
                    }
                }
            }
            .overlay {
                if expenses.isEmpty{
                    ContentUnavailableView(label: {
                        Label("No Expenses", systemImage: "list.bullet.rectangle.portrait")
                    }, description: {
                        Text("Start adding expenses to see your list.")
                    }, actions: {
                        Button("Add Expense") {
                            isShowingItemSheet = true
                        }
                    })
                    .offset(y: -60)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

//struct ExpenseCell: View {
//    
//    let expense: Expense
//    
//    var body: some View {
//        HStack {
//            Text(formatDate(expense.date))
//                .frame(width: 70, alignment: .leading)
//            Text(expense.name)
//            Spacer()
//            Text(expense.value, format: .currency(code: "USD"))
//        }
//    }
//    
//    private func formatDate(_ date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMM dd" // Customize the date format as per your need
//        return formatter.string(from: date)
//    }
//}


//struct AddExpenseSheet: View {
//    @Environment(\.modelContext) var context
//    @Environment(\.dismiss) private var dismiss
//    
//    @State private var name: String = ""
//    @State private var date: Date = .now
//    @State private var value: Double = 0
//    
//    var body: some View {
//        NavigationStack{
//            Form{
//                TextField("Expense Name", text: $name)
//                DatePicker("Date", selection: $date, displayedComponents: .date)
//                TextField("Value", value: $value, format: .currency(code: "USD"))
//                    .keyboardType(.decimalPad)
//            }
//            .navigationTitle("New Expense")
//            .navigationBarTitleDisplayMode(.large)
//            .toolbar {
//                ToolbarItemGroup(placement: .topBarLeading){
//                    Button("Cancel"){ dismiss() }
//                }
//                ToolbarItemGroup(placement: .topBarTrailing){
//                    Button("Save"){
//                        let expense = Expense(name: name, date: date, value: value)
//                        context.insert(expense)
//                        
////                        Dont need this since it auto saves.
////                        try! context.save()
//                        dismiss()
//                    }
//                }
//            }
//        }
//    }
//}

//struct UpdateExpenseSheet: View {
//    @Environment(\.dismiss) private var dismiss
//    @Bindable var expense: Expense
//    
//    var body: some View {
//        NavigationStack{
//            Form{
//                TextField("Expense Name", text: $expense.name)
//                DatePicker("Date", selection: $expense.date, displayedComponents: .date)
//                TextField("Value", value: $expense.value, format: .currency(code: "USD"))
//                    .keyboardType(.decimalPad)
//            }
//            .navigationTitle("Update Expense")
//            .navigationBarTitleDisplayMode(.large)
//            .toolbar {
//                ToolbarItemGroup(placement: .topBarTrailing){
//                    Button("Done"){ dismiss() }
//                }
//            }
//        }
//    }
//}

