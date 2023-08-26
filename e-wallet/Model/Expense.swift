//
//  Expense.swift
//  e-wallet
//
//  Created by dani prayogi on 01/04/22.
//

import SwiftUI

struct Expense: Identifiable {
    var id = UUID().uuidString
    var amountSpent: String
    var product: String
    var productIcon: String
    var spendType: String
}

var expenses: [Expense] = [
    Expense(amountSpent: "$459", product: "Apple", productIcon: "Apple", spendType: "Groceries"),
    Expense(amountSpent: "$459", product: "Apple", productIcon: "Apple", spendType: "Groceries"),
    Expense(amountSpent: "$459", product: "Apple", productIcon: "Apple", spendType: "Groceries"),
    Expense(amountSpent: "$459", product: "Apple", productIcon: "Apple", spendType: "Groceries"),
    Expense(amountSpent: "$459", product: "Apple", productIcon: "Apple", spendType: "Groceries"),
    Expense(amountSpent: "$459", product: "Apple", productIcon: "Apple", spendType: "Groceries"),
    Expense(amountSpent: "$459", product: "Apple", productIcon: "Apple", spendType: "Groceries"),
    Expense(amountSpent: "$459", product: "Apple", productIcon: "Apple", spendType: "Groceries"),
    Expense(amountSpent: "$459", product: "Apple", productIcon: "Apple", spendType: "Groceries"),
    Expense(amountSpent: "$459", product: "Apple", productIcon: "Apple", spendType: "Groceries"),
    Expense(amountSpent: "$459", product: "Apple", productIcon: "Apple", spendType: "Groceries"),
    Expense(amountSpent: "$459", product: "Apple", productIcon: "Apple", spendType: "Groceries"),
    Expense(amountSpent: "$459", product: "Apple", productIcon: "Apple", spendType: "Groceries"),
    Expense(amountSpent: "$459", product: "Apple", productIcon: "Apple", spendType: "Groceries"),
    Expense(amountSpent: "$459", product: "Apple", productIcon: "Apple", spendType: "Groceries"),
    Expense(amountSpent: "$459", product: "Apple", productIcon: "Apple", spendType: "Groceries"),
    Expense(amountSpent: "$459", product: "Apple", productIcon: "Apple", spendType: "Groceries"),
    Expense(amountSpent: "$459", product: "Apple", productIcon: "Apple", spendType: "Groceries"),
    Expense(amountSpent: "$459", product: "Apple", productIcon: "Apple", spendType: "Groceries"),
    Expense(amountSpent: "$459", product: "Apple", productIcon: "Apple", spendType: "Groceries"),
    Expense(amountSpent: "$459", product: "Apple", productIcon: "Apple", spendType: "Groceries"),
]
