//
//  Card.swift
//  e-wallet
//
//  Created by dani prayogi on 19/03/22.
//

import SwiftUI

struct Card: Identifiable{
    var id = UUID().uuidString
    var name : String
    var cardNumber : String
    var cardImage : String
}

var cards: [Card] = [
    Card(name: "dani aja", cardNumber: "3123 2311 3212 2321", cardImage: "Card4"),
    Card(name: "dani doang", cardNumber: "2343 4223 4242 0234", cardImage: "Card2"),
    Card(name: "dani udah", cardNumber: "2434 4224 3324 1321", cardImage: "Card3"),
]
