//
//  ExpenseCell.swift
//  SwiftDataExample
//
//  Created by Mike Iannotti on 3/24/24.
//

import SwiftUI
import SwiftData

struct ExpenseCell: View {
    
    let expense: Expense
    
    var body: some View {
        HStack {
            Text(formatDate(expense.date))
                .frame(width: 70, alignment: .leading)
            Text(expense.name)
            Spacer()
            Text(expense.value, format: .currency(code: "USD"))
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd" // Customize the date format as per your need
        return formatter.string(from: date)
    }
}
